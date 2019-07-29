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
          MoceanTest::TestingUtils.intercept_http_request(
              'verify_code.json',
              '/verify/check'
          ) do |method, uri|
            assert_equal method, :post
            assert_equal uri.path, MoceanTest::TestingUtils.test_uri('/verify/check')
          end

          client = MoceanTest::TestingUtils.client_obj
          res = client.verify_validate.send(
              'mocean-reqid': 'test reqid', 'mocean-code': 'test code'
          )

          assert_equal res.to_s, MoceanTest::TestingUtils.response_str('verify_code.json')
          object_test(res)
        end

        def test_xml_send
          MoceanTest::TestingUtils.intercept_http_request(
              'verify_code.xml',
              '/verify/check'
          ) do |method, uri|
            assert_equal method, :post
            assert_equal uri.path, MoceanTest::TestingUtils.test_uri('/verify/check')
          end

          client = MoceanTest::TestingUtils.client_obj
          res = client.verify_validate.send(
              'mocean-reqid': 'test reqid', 'mocean-code': 'test code', 'mocean-resp-format': 'xml'
          )

          assert_equal res.to_s, MoceanTest::TestingUtils.response_str('verify_code.xml')
          object_test(res)
        end

        def test_required_field_not_set
          MoceanTest::TestingUtils.intercept_http_request(
              'verify_code.json',
              '/verify/check'
          )

          client = MoceanTest::TestingUtils.client_obj
          assert_raises Moceansdk::Exceptions::RequiredFieldException do
            client.verify_validate.send
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