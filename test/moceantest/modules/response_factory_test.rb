require_relative '../mocean_testing'
module Moceansdk
  module Modules

    class ResponseFactoryTest < MoceanTest::Test
      def test_parse_malformed_response
        assert_raises Moceansdk::Exceptions::MoceanError do
          ResponseFactory.create_object 'malformed string'
        end
      end
    end

  end
end
