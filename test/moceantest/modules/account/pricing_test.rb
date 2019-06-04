require_relative '../../mocean_testing'
module Moceansdk
  module Modules
    module Account

      class PricingTest < MoceanTest::Test
        def setup
          @client = MoceanTest::TestingUtils.client_obj
        end

        def test_setter
          pricing = @client.pricing

          pricing.mcc = 'test mcc'
          refute pricing.params['mocean-mcc'].nil?
          assert_equal 'test mcc', pricing.params['mocean-mcc']

          pricing.mnc = 'test mnc'
          refute pricing.params['mocean-mnc'].nil?
          assert_equal 'test mnc', pricing.params['mocean-mnc']

          pricing.delimiter = 'test delimiter'
          refute pricing.params['mocean-delimiter'].nil?
          assert_equal 'test delimiter', pricing.params['mocean-delimiter']

          pricing.resp_format = 'json'
          refute pricing.params['mocean-resp-format'].nil?
          assert_equal 'json', pricing.params['mocean-resp-format']
        end

        def test_inquiry
          fake = Minitest::Mock.new
          fake.expect :call, 'testing only', [String, String, Hash]

          transmitter_mock = Moceansdk::Modules::Transmitter.new
          transmitter_mock.stub(:request, lambda {|method, uri, params|
            assert_equal method, 'get'
            assert_equal uri, '/account/pricing'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)
            assert_equal client.pricing.inquiry, 'testing only'
          end

          assert fake.verify
        end

        def test_json_response
          file_content = File.read(MoceanTest::TestingUtils.resource_file_path('price.json'))
          fake = Minitest::Mock.new
          transmitter_mock = Moceansdk::Modules::Transmitter.new

          fake.expect :call, transmitter_mock.format_response(file_content), [String, String, Hash]
          transmitter_mock.stub(:request, lambda {|method, uri, params|
            assert_equal method, 'get'
            assert_equal uri, '/account/pricing'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)
            res = client.pricing.inquiry

            assert_equal res.to_s, file_content
            object_test(res)
          end

          assert fake.verify
        end

        def test_xml_response
          file_content = File.read(MoceanTest::TestingUtils.resource_file_path('price.xml'))
          fake = Minitest::Mock.new
          transmitter_mock = Moceansdk::Modules::Transmitter.new(version: '1')

          fake.expect :call, transmitter_mock.format_response(file_content, true, '/account/pricing'), [String, String, Hash]
          transmitter_mock.stub(:request, lambda {|method, uri, params|
            assert_equal method, 'get'
            assert_equal uri, '/account/pricing'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)
            res = client.pricing.inquiry

            assert_equal res.to_s, file_content
            object_test(res)
          end

          assert fake.verify


          # v2 test
          file_content = File.read(MoceanTest::TestingUtils.resource_file_path('price_v2.xml'))
          fake = Minitest::Mock.new
          transmitter_mock = Moceansdk::Modules::Transmitter.new(version: '2')

          fake.expect :call, transmitter_mock.format_response(file_content, true, '/account/pricing'), [String, String, Hash]
          transmitter_mock.stub(:request, lambda {|method, uri, params|
            assert_equal method, 'get'
            assert_equal uri, '/account/pricing'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)
            res = client.pricing.inquiry

            assert_equal res.to_s, file_content
            object_test(res)
          end

          assert fake.verify
        end

        private

        def object_test(pricing_response)
          assert_equal pricing_response.status, '0'
          assert_equal pricing_response.destinations.length, 25
          assert_equal pricing_response.destinations[0].country, 'Default'
          assert_equal pricing_response.destinations[0].operator, 'Default'
          assert_equal pricing_response.destinations[0].mcc, 'Default'
          assert_equal pricing_response.destinations[0].mnc, 'Default'
          assert_equal pricing_response.destinations[0].price, '2.0000'
          assert_equal pricing_response.destinations[0].currency, 'MYR'
        end
      end

    end
  end
end