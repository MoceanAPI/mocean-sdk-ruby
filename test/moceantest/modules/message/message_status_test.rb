require_relative '../../mocean_testing'
module Moceansdk
  module Modules
    module Message

      class MessageStatusTest < MoceanTest::Test
        def setup
          @client = MoceanTest::TestingUtils.client_obj
        end

        def test_setter
          message_status = @client.message_status

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
          transmitter_mock.stub(:request, lambda {|method, uri, params|
            assert_equal method, 'get'
            assert_equal uri, '/report/message'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)
            assert_equal client.message_status.inquiry('mocean-msgid': 'test msgid'), 'testing only'
          end

          assert fake.verify
        end

        def test_json_response
          file_content = File.read(MoceanTest::TestingUtils.resource_file_path('message_status.json'))
          fake = Minitest::Mock.new
          transmitter_mock = Moceansdk::Modules::Transmitter.new

          fake.expect :call, transmitter_mock.format_response(file_content), [String, String, Hash]
          transmitter_mock.stub(:request, lambda {|method, uri, params|
            assert_equal method, 'get'
            assert_equal uri, '/report/message'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)
            res = client.message_status.inquiry('mocean-msgid': 'test msgid')

            assert_equal res.to_s, file_content
            object_test(res)
          end

          assert fake.verify
        end

        def test_xml_response
          file_content = File.read(MoceanTest::TestingUtils.resource_file_path('message_status.xml'))
          fake = Minitest::Mock.new
          transmitter_mock = Moceansdk::Modules::Transmitter.new

          fake.expect :call, transmitter_mock.format_response(file_content, true, '/report/message'), [String, String, Hash]
          transmitter_mock.stub(:request, lambda {|method, uri, params|
            assert_equal method, 'get'
            assert_equal uri, '/report/message'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)
            res = client.message_status.inquiry('mocean-msgid': 'test msgid')

            assert_equal res.to_s, file_content
            object_test(res)
          end

          assert fake.verify
        end

        private

        def object_test(message_status_response)
          assert_equal message_status_response.status, '0'
          assert_equal message_status_response.message_status, '5'
          assert_equal message_status_response.msgid, 'CPASS_restapi_C0000002737000000.0001'
          assert_equal message_status_response.credit_deducted, '0.0000'
        end
      end

    end
  end
end