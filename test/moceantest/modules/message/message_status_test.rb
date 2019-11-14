require_relative '../../mocean_testing'
module Moceansdk
  module Modules
    module Message

      class MessageStatusTest < MoceanTest::Test
        def test_setter
          message_status = MoceanTest::TestingUtils.client_obj.message_status

          message_status.msgid = 'test msgid'
          refute message_status.params['mocean-msgid'].nil?
          assert_equal 'test msgid', message_status.params['mocean-msgid']

          message_status.resp_format = 'json'
          refute message_status.params['mocean-resp-format'].nil?
          assert_equal 'json', message_status.params['mocean-resp-format']
        end

        def test_json_inquiry
          MoceanTest::TestingUtils.mock_http_request('/report/message') do |request|
            assert_equal request.method, :get
            verify_params_with(request.body, {'mocean-msgid': 'test msgid'})
            file_response('message_status.json')
          end

          client = MoceanTest::TestingUtils.client_obj
          res = client.message_status.inquiry('mocean-msgid': 'test msgid')
          object_test(res)
        end

        def test_xml_inquiry
          MoceanTest::TestingUtils.mock_http_request('/report/message') do |request|
            assert_equal request.method, :get
            verify_params_with(request.body, {'mocean-msgid': 'test msgid'})
            file_response('message_status.xml')
          end

          client = MoceanTest::TestingUtils.client_obj
          res = client.message_status.inquiry('mocean-msgid': 'test msgid', 'mocean-resp-format': 'xml')
          object_test(res)
        end

        def test_required_param_missing
          MoceanTest::TestingUtils.mock_http_request('/report/message') do
            file_response('message_status.json')
          end

          assert_raises Moceansdk::Exceptions::RequiredFieldException do
            MoceanTest::TestingUtils.client_obj.message_status.inquiry
          end
        end

        private

        def object_test(message_status_response)
          assert_equal message_status_response.to_hash, message_status_response.inspect
          assert_equal message_status_response.status, '0'
          assert_equal message_status_response.message_status, '5'
          assert_equal message_status_response.msgid, 'CPASS_restapi_C0000002737000000.0001'
          assert_equal message_status_response.credit_deducted, '0.0000'
        end
      end

    end
  end
end