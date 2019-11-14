require_relative '../../mocean_testing'
module Moceansdk
  module Modules
    module NumberLookup

      class NumberLookupTest < MoceanTest::Test
        def test_setter
          number_lookup = MoceanTest::TestingUtils.client_obj.number_lookup

          number_lookup.to = 'test to'
          refute number_lookup.params['mocean-to'].nil?
          assert_equal 'test to', number_lookup.params['mocean-to']

          number_lookup.nl_url = 'test nl url'
          refute number_lookup.params['mocean-nl-url'].nil?
          assert_equal 'test nl url', number_lookup.params['mocean-nl-url']

          number_lookup.resp_format = 'json'
          refute number_lookup.params['mocean-resp-format'].nil?
          assert_equal 'json', number_lookup.params['mocean-resp-format']
        end

        def test_json_inquiry
          MoceanTest::TestingUtils.mock_http_request('/nl') do |request|
            assert_equal request.method, :post
            verify_params_with(request.body, {'mocean-to': 'test to'})
            file_response('number_lookup.json')
          end

          client = MoceanTest::TestingUtils.client_obj
          res = client.number_lookup.inquiry('mocean-to': 'test to')
          object_test(res)
        end

        def test_xml_inquiry
          MoceanTest::TestingUtils.mock_http_request('/nl') do |request|
            assert_equal request.method, :post
            verify_params_with(request.body, {'mocean-to': 'test to'})
            file_response('number_lookup.xml')
          end

          client = MoceanTest::TestingUtils.client_obj
          res = client.number_lookup.inquiry('mocean-to': 'test to', 'mocean-resp-format': 'xml')
          object_test(res)
        end

        def test_required_param_missing
          MoceanTest::TestingUtils.mock_http_request('/nl') do
            file_response('number_lookup.json')
          end

          assert_raises Moceansdk::Exceptions::RequiredFieldException do
            MoceanTest::TestingUtils.client_obj.number_lookup.inquiry
          end
        end

        private

        def object_test(number_lookup_response)
          assert_equal number_lookup_response.to_hash, number_lookup_response.inspect
          assert_equal number_lookup_response.status, '0'
          assert_equal number_lookup_response.msgid, 'CPASS_restapi_C00000000000000.0002'
          assert_equal number_lookup_response.to, '60123456789'
          assert_equal number_lookup_response.current_carrier.country, 'MY'
          assert_equal number_lookup_response.current_carrier.name, 'U Mobile'
          assert_equal number_lookup_response.current_carrier.network_code, '50218'
          assert_equal number_lookup_response.current_carrier.mcc, '502'
          assert_equal number_lookup_response.current_carrier.mnc, '18'
          assert_equal number_lookup_response.original_carrier.country, 'MY'
          assert_equal number_lookup_response.original_carrier.name, 'Maxis Mobile'
          assert_equal number_lookup_response.original_carrier.network_code, '50212'
          assert_equal number_lookup_response.original_carrier.mcc, '502'
          assert_equal number_lookup_response.original_carrier.mnc, '12'
          assert_equal number_lookup_response.ported, 'ported'
          assert_equal number_lookup_response.reachable, 'reachable'
        end
      end

    end
  end
end