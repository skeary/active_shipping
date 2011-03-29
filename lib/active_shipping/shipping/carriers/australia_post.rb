module ActiveMerchant
  module Shipping
    class AustraliaPost < Carrier

      cattr_reader :name, :api_url
      cattr_writer :default_location

      @@name = "Australia Post"
      @@default_location = Location.new(:postal_code => '2000', :country => 'Australia')
      @@api_url = "http://drc.edeliver.com.au/ratecalc.asp"

      def find_rates(origin, destination, package, options = {})
        rates = []

        origin = self.class.default_location unless origin.is_a?(Location)

        options[:service_type] = Array(options[:service_type]).flatten
        if options[:service_type].empty?
          if destination.country.to_s == 'Australia'
            options[:service_type] = %w[STANDARD EXPRESS]
          else
            options[:service_type] = %w[AIR SEA]
          end
        end

        options[:service_type].each do |service_type|
          rate_request_url = build_rate_request(origin, destination, package, {:service_type => service_type})
          response = ssl_get(rate_request_url)
          rates << parse_rate_response(origin, destination, package, response, {:service_type => service_type})
        end

        rates
      end

    protected

      def self.default_location
        @@default_location
      end

    private

      def build_rate_request(origin, destination, package, options)
        self.class.api_url + "?" + {
          Pickup_Postcode: destination.postal_code,
          Destination_Postcode: origin.postal_code,
          Country: destination.country.code(:alpha2),
          Service_Type: options[:service_type],
          Weight: package.grams,
          Length: package.centimetres(:length) * 10,
          Width: package.centimetres(:width) * 10,
          Height: package.centimetres(:height) * 10,
          Quantity: 1
        }.to_param
      end

      def parse_rate_response(origin, destination, package, response, options)
        price = nil, delivery_date = nil

        response.scan( /(\w+)=(.+)/ ).each do |key, value|
          value.strip!

          case key
          when 'charge'
            price = value.to_f
          when 'days'
            delivery_date = value.to_i.days.from_now
          when 'err_msg'
            raise "Error: #{value}" unless value == "OK"
          else
            raise "Unknown response from #{self.class.api_url}: #{key} => #{value}"
          end
        end

        RateEstimate.new(origin, destination, self.class.name, options[:service_type], 
          :total_price => price, :currency => 'AUD', :package => package, :delivery_date => delivery_date)
      end
    end
  end
end
