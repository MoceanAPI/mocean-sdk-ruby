require_relative '../../mocean_testing'
module Moceansdk
  module Modules
    module Account

      class PricingTest < MoceanTest::Test
        def test_setter
          pricing = MoceanTest::TestingUtils.client_obj.pricing

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

        def test_json_inquiry
          MoceanTest::TestingUtils.new_mock_http_request('/account/pricing') do |request|
            assert_equal request.method, :get
            file_response('price.json')
          end

          client = MoceanTest::TestingUtils.client_obj
          res = client.pricing.inquiry
          object_test(res)
        end

        def test_xml_response
          MoceanTest::TestingUtils.new_mock_http_request('/account/pricing', '1') do |request|
            assert_equal request.method, :get
            file_response('price.xml')
          end

          client = MoceanTest::TestingUtils.client_obj(Moceansdk::Modules::Transmitter.new(version: '1'))
          res = client.pricing.inquiry({'mocean-resp-format': 'xml'})
          object_test(res)

          # v2 test
          MoceanTest::TestingUtils.new_mock_http_request('/account/pricing') do |request|
            assert_equal request.method, :get
            file_response('price_v2.xml')
          end

          client = MoceanTest::TestingUtils.client_obj
          res = client.pricing.inquiry({'mocean-resp-format': 'xml'})
          object_test(res)
        end

        private

        def object_test(pricing_response)
          assert_equal pricing_response.to_hash, pricing_response.inspect
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