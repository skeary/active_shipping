require 'test_helper'

class AustraliaPostTest < Test::Unit::TestCase

  def setup
    @packages = TestFixtures.packages
    @locations = TestFixtures.locations
    @carrier = AustraliaPost.new
  end

  def test_successful_rate_request
    # local postage
    %w[STANDARD EXPRESS].each do |service_type|
      rates = @carrier.find_rates(@locations[:sydney], @locations[:melbourne], @packages[:book], :service_type => service_type)
      assert rates.any?
      assert rates.first.is_a? RateEstimate
      assert_equal rates.size, 1
    end

    @carrier.find_rates(@locations[:sydney], @locations[:melbourne], @packages[:book]).each do |rate|
      assert rate.service_name =~ /STANDARD|EXPRESS/
    end

    # international postage
    %w[AIR SEA].each do |service_type|
      rates = @carrier.find_rates(@locations[:sydney], @locations[:beverly_hills], @packages[:book], :service_type => service_type)
      assert rates.any?
      assert rates.first.is_a? RateEstimate
      assert_equal rates.size, 1
    end

    @carrier.find_rates(@locations[:sydney], @locations[:beverly_hills], @packages[:book]).each do |rate|
      assert rate.service_name =~ /AIR|SEA/
    end
  end

  def test_failure_rate_request
    begin
      # can't use air service for local
      @carrier.find_rates(@locations[:sydney], @locations[:melbourne], @packages.values_at(:book), 'AIR')

      flunk "expected an ActiveMerchant::Shipping::ResponseError to be raised"
    rescue => exception
    end

    begin
      # economy no longer available
      @carrier.find_rates(@locations[:sydney], @locations[:wellington], @packages.values_at(:book), 'ECONOMY')

      flunk "expected an ActiveMerchant::Shipping::ResponseError to be raised"
    rescue => exception
    end
  end
end
