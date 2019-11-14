require_relative '../../mocean_testing'
module Moceansdk
  module Modules
    module Message

      class VerifyValidateTest < MoceanTest::Test
        def test_setter
          verify_validate = MoceanTest::TestingUtils.client_obj.verify_validate

          verify_validate.reqid = 'test reqid'
          refute verify_validate.params['mocean-reqid'].nil?
          assert_equal 'test reqid', verify_validate.params['mocean-reqid']

          verify_validate.code = 'test code'
          refute verify_validate.params['mocean-code'].nil?
          assert_equal 'test code', verify_validate.params['mocean-code']

          verify_validate.resp_format = 'json'
          refute verify_validate.params['mocean-resp-format'].nil?
          assert_equal 'json', verify_validate.params['mocean-resp-format']
        end

        def test_json_send
          MoceanTest::TestingUtils.mock_http_request('/verify/check') do |request|
            assert_equal request.method, :post
            verify_params_with(request.body, {'mocean-reqid': 'test reqid', 'mocean-code': 'test code'})
            file_response('verify_code.json')
          end

          client = MoceanTest::TestingUtils.client_obj
          res = client.verify_validate.send('mocean-reqid': 'test reqid', 'mocean-code': 'test code')
          object_test(res)
        end

        def test_xml_send
          MoceanTest::TestingUtils.mock_http_request('/verify/check') do |request|
            assert_equal request.method, :post
            verify_params_with(request.body, {'mocean-reqid': 'test reqid', 'mocean-code': 'test code'})
            file_response('verify_code.xml')
          end

          client = MoceanTest::TestingUtils.client_obj
          res = client.verify_validate.send('mocean-reqid': 'test reqid', 'mocean-code': 'test code', 'mocean-resp-format': 'xml')
          object_test(res)
        end

        def test_required_param_missing
          MoceanTest::TestingUtils.mock_http_request('/verify/check') do
            file_response('verify_code.json')
          end

          assert_raises Moceansdk::Exceptions::RequiredFieldException do
            MoceanTest::TestingUtils.client_obj.verify_validate.send
          end
        end

        private

        def object_test(verify_validate_response)
          assert_equal verify_validate_response.to_hash, verify_validate_response.inspect
          assert_equal verify_validate_response.status, '0'
          assert_equal verify_validate_response.reqid, 'CPASS_restapi_C0000002737000000.0002'
        end
      end

    end
  end
end