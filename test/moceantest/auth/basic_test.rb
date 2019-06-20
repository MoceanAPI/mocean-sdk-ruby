require_relative '../mocean_testing'
module Moceansdk
  module Auth

    class BasicTest < MoceanTest::Test
      def setup
        @basic = Basic.new
      end

      def test_set_api_key
        @basic.api_key = 'test api key'

        assert_equal @basic.params['mocean-api-key'], 'test api key'
      end

      def test_set_api_secret
        @basic.api_secret = 'test api secret'

        assert_equal @basic.params['mocean-api-secret'], 'test api secret'
      end

      def test_get_params
        @basic.api_key = 'test api key'
        @basic.api_secret = 'test api secret'

        assert_equal @basic.params['mocean-api-key'], 'test api key'
        assert_equal @basic.params['mocean-api-secret'], 'test api secret'
      end
    end

  end
end
