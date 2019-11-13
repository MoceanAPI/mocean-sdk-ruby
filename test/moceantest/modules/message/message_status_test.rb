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

        def test_inquiry
          fake = Minitest::Mock.new
          fake.expect :call, 'testing only', [String, String, Hash]

          transmitter_mock = Moceansdk::Modules::Transmitter.new
          transmitter_mock.stub(:request_and_parse_body, lambda {|method, uri, params|
            assert_equal method, 'get'
            assert_equal uri, '/report/message'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)

            assert_raises Moceansdk::Exceptions::RequiredFieldException do
              client.message_status.inquiry
            end

            assert_equal client.message_status.inquiry('mocean-msgid': 'test msgid'), 'testing only'
          end

          client = MoceanTest::TestingUtils.client_obj
          res = client.message_status.inquiry('mocean-msgid': 'test msgid')

        def test_json_response
          file_content = File.read(MoceanTest::TestingUtils.resource_file_path('message_status.json'))
          fake = Minitest::Mock.new
          transmitter_mock = Moceansdk::Modules::Transmitter.new

          fake.expect :call, transmitter_mock.format_response(file_content), [String, String, Hash]
          transmitter_mock.stub(:request_and_parse_body, lambda {|method, uri, params|
            assert_equal method, 'get'
            assert_equal uri, '/report/message'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)
            res = client.message_status.inquiry('mocean-msgid': 'test msgid')

        def test_xml_inquiry
          MoceanTest::TestingUtils.intercept_http_request(
              'message_status.xml',
              '/report/message'
          ) do |method, uri|
            assert_equal method, :get
            assert_equal uri.path, MoceanTest::TestingUtils.test_uri('/report/message')
          end

          client = MoceanTest::TestingUtils.client_obj
          res = client.message_status.inquiry('mocean-msgid': 'test msgid', 'mocean-resp-format': 'xml')

          assert_equal res.to_s, MoceanTest::TestingUtils.response_str('message_status.xml')
          object_test(res)
        end

        fake.expect :call, transmitter_mock.format_response(file_content, true, '/report/message'), [String, String, Hash]
          transmitter_mock.stub(:request_and_parse_body, lambda {|method, uri, params|
            assert_equal method, 'get'
            assert_equal uri, '/report/message'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)
            res = client.message_status.inquiry('mocean-msgid': 'test msgid')

          client = MoceanTest::TestingUtils.client_obj
          assert_raises Moceansdk::Exceptions::RequiredFieldException do
            client.message_status.inquiry
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