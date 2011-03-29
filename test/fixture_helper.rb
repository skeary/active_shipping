module ActiveMerchant
  module Shipping
    module TestFixtures
      
      mattr_reader :packages, :locations
      
      @@packages = {
        :just_ounces => Package.new(16, nil, :units => :imperial),
        :just_grams => Package.new(1000, nil),
        :all_imperial => Package.new(16, [1,8,12], :units => :imperial),
        :all_metric => Package.new(1000, [2,20,40]),
        :book => Package.new(250, [14, 19, 2]),
        :wii => Package.new((7.5 * 16), [15, 10, 4.5], :units => :imperial, :value => 269.99, :currency => 'GBP'),
        :american_wii => Package.new((7.5 * 16), [15, 10, 4.5], :units => :imperial, :value => 269.99, :currency => 'USD'),
        :worthless_wii => Package.new((7.5 * 16), [15, 10, 4.5], :units => :imperial, :value => 0.0, :currency => 'USD'),
        :poster => Package.new(100, [93,10], :cylinder => true),
        :small_half_pound => Package.new(8, [1,1,1], :units => :imperial),
        :big_half_pound => Package.new((16 * 50), [24,24,36], :units => :imperial),
        :chocolate_stuff => Package.new(80, [2,6,12], :units => :imperial),
        :shipping_container => Package.new(2200000, [2440, 2600, 6058], :description => '20 ft Standard Container', :units => :metric)
      }
      
      @@locations = {
        :bare_ottawa => Location.new(:country => 'CA', :postal_code => 'K1P 1J1'),
        :bare_beverly_hills => Location.new(:country => 'US', :zip => '90210'),
        :ottawa => Location.new(:country => 'CA', :province => 'ON', :city => 'Ottawa',
                                      :address1 => '110 Laurier Avenue West', :postal_code => 'K1P 1J1',
                                      :phone => '1-613-580-2400', :fax => '1-613-580-2495'),
        :beverly_hills => Location.new(:country => 'US', :state => 'CA', :city => 'Beverly Hills',
                                      :address1 => '455 N. Rexford Dr.', :address2 => '3rd Floor', :zip => '90210',
                                      :phone => '1-310-285-1013', :fax => '1-310-275-8159'),
        :real_home_as_commercial => Location.new(
                                      :country => 'US',
                                      :city => 'Tampa',
                                      :state => 'FL',
                                      :address1 => '7926 Woodvale Circle',
                                      :zip => '33615',
                                      :address_type => 'commercial'), # means that UPS will default to commercial if it doesn't know
        :fake_home_as_commercial => Location.new(
                                      :country => 'US',
                                      :state => 'FL',
                                      :address1 => '123 fake st.',
                                      :zip => '33615',
                                      :address_type => 'commercial'),
        :real_google_as_commercial => Location.new(
                                      :country => 'US',
                                      :city => 'Mountain View',
                                      :state => 'CA',
                                      :address1 => '1600 Amphitheatre Parkway',
                                      :zip => '94043',
                                      :address_type => 'commercial'),
        :real_google_as_residential => Location.new(
                                      :country => 'US',
                                      :city => 'Mountain View',
                                      :state => 'CA',
                                      :address1 => '1600 Amphitheatre Parkway',
                                      :zip => '94043',
                                      :address_type => 'residential'), # means that will default to residential if it doesn't know
        :fake_google_as_commercial => Location.new(
                                      :country => 'US',
                                      :city => 'Mountain View',
                                      :state => 'CA',
                                      :address1 => '123 bogusland dr.',
                                      :zip => '94043',
                                      :address_type => 'commercial'),
        :fake_google_as_residential => Location.new(
                                      :country => 'US',
                                      :city => 'Mountain View',
                                      :state => 'CA',
                                      :address1 => '123 bogusland dr.',
                                      :zip => '94043',
                                      :address_type => 'residential'), # means that will default to residential if it doesn't know
        :fake_home_as_residential => Location.new(
                                      :country => 'US',
                                      :state => 'FL',
                                      :address1 => '123 fake st.',
                                      :zip => '33615',
                                      :address_type => 'residential'),
        :real_home_as_residential => Location.new(
                                      :country => 'US',
                                      :city => 'Tampa',
                                      :state => 'FL',
                                      :address1 => '7926 Woodvale Circle',
                                      :zip => '33615',
                                      :address_type => 'residential'),
        :london => Location.new(
                                      :country => 'GB',
                                      :city => 'London',
                                      :address1 => '170 Westminster Bridge Rd.',
                                      :zip => 'SE1 7RW'),
        :new_york => Location.new(
                                      :country => 'US',
                                      :city => 'New York',
                                      :state => 'NY',
                                      :address1 => '780 3rd Avenue',
                                      :address2 => 'Suite  2601',
                                      :zip => '10017'),
        :new_york_with_name => Location.new(
                                      :name => "Bob Bobsen",
                                      :country => 'US',
                                      :city => 'New York',
                                      :state => 'NY',
                                      :address1 => '780 3rd Avenue',
                                      :address2 => 'Suite  2601',
                                      :zip => '10017'),
        :wellington => Location.new(
                                      :country => 'NZ',
                                      :city => 'Wellington',
                                      :address1 => '85 Victoria St',
                                      :address2 => 'Te Aro',
                                      :postal_code => '6011'),
        :sydney => Location.new(
                                      :country => 'Australia',
                                      :city => 'Sydney',
                                      :address1 => '1 Regent St',
                                      :address2 => 'Suite 101',
                                      :postal_code => '2000'),
        :melbourne => Location.new(
                                      :country => 'Australia',
                                      :city => 'Melbourne',
                                      :address1 => '1 Collins St',
                                      :address2 => 'Suite 101',
                                      :postal_code => '3000')
      }
      
    end
  end
end

