require_relative '../../mocean_testing'
module Moceansdk
  module Modules
    module Message

      class VerifyRequestTest < MoceanTest::Test
        def setup
          @client = MoceanTest::TestingUtils.client_obj
        end

        def test_setter
          verify_request = @client.verify_request

          verify_request.to = 'test to'
          refute verify_request.params['mocean-to'].nil?
          assert_equal 'test to', verify_request.params['mocean-to']

          verify_request.brand = 'test brand'
          refute verify_request.params['mocean-brand'].nil?
          assert_equal 'test brand', verify_request.params['mocean-brand']

          verify_request.from = 'test from'
          refute verify_request.params['mocean-from'].nil?
          assert_equal 'test from', verify_request.params['mocean-from']

          verify_request.code_length = 'test code length'
          refute verify_request.params['mocean-code-length'].nil?
          assert_equal 'test code length', verify_request.params['mocean-code-length']

          verify_request.template = 'test template'
          refute verify_request.params['mocean-template'].nil?
          assert_equal 'test template', verify_request.params['mocean-template']

          verify_request.pin_validity = 'test pin validity'
          refute verify_request.params['mocean-pin-validity'].nil?
          assert_equal 'test pin validity', verify_request.params['mocean-pin-validity']

          verify_request.next_event_wait = 'test next event wait'
          refute verify_request.params['mocean-next-event-wait'].nil?
          assert_equal 'test next event wait', verify_request.params['mocean-next-event-wait']

          verify_request.resp_format = 'json'
          refute verify_request.params['mocean-resp-format'].nil?
          assert_equal 'json', verify_request.params['mocean-resp-format']
        end

        def test_send
          fake = Minitest::Mock.new
          fake.expect :call, 'testing only', [String, String, Hash]

          transmitter_mock = Moceansdk::Modules::Transmitter.new
          transmitter_mock.stub(:request_and_parse_body, lambda {|method, uri, params|
            assert_equal method, 'post'
            assert_equal uri, '/verify/req'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)

            assert_raises Moceansdk::Exceptions::RequiredFieldException do
              client.verify_request.send
            end

            assert_equal(client.verify_request.send(
                'mocean-to': 'test to', 'mocean-brand': 'test-brand'
            ), 'testing only')
          end

          assert fake.verify
        end

        def test_send_as_sms_channel
          fake = Minitest::Mock.new
          fake.expect :call, 'testing only', [String, String, Hash]

          transmitter_mock = Moceansdk::Modules::Transmitter.new
          transmitter_mock.stub(:request_and_parse_body, lambda {|method, uri, params|
            assert_equal method, 'post'
            assert_equal uri, '/verify/req/sms'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)
            verify_request = client.verify_request
            assert_equal verify_request.channel, Channel::AUTO
            verify_request.send_as Channel::SMS
            assert_equal verify_request.channel, Channel::SMS
            assert_equal(verify_request.send(
                'mocean-to': 'test to', 'mocean-brand': 'test-brand'
            ), 'testing only')
          end

          assert fake.verify
        end

        def test_resend
          fake = Minitest::Mock.new
          fake.expect :call, 'testing only', [String, String, Hash]

          transmitter_mock = Moceansdk::Modules::Transmitter.new
          transmitter_mock.stub(:request_and_parse_body, lambda {|method, uri, params|
            assert_equal method, 'post'
            assert_equal uri, '/verify/resend/sms'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)
            assert_equal(client.verify_request.resend(
                'mocean-reqid': 'test reqid'
            ), 'testing only')
          end

          assert fake.verify
        end

        def test_json_response
          file_content = File.read(MoceanTest::TestingUtils.resource_file_path('send_code.json'))
          fake = Minitest::Mock.new
          transmitter_mock = Moceansdk::Modules::Transmitter.new

          fake.expect :call, transmitter_mock.format_response(file_content), [String, String, Hash]
          transmitter_mock.stub(:request_and_parse_body, lambda {|method, uri, params|
            assert_equal method, 'post'
            assert_equal uri, '/verify/req'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)
            res = client.verify_request.send(
                'mocean-to': 'test to', 'mocean-brand': 'test-brand'
            )

            assert_equal res.to_s, file_content
            object_test(res)
          end

          assert fake.verify
        end

        def test_xml_response
          file_content = File.read(MoceanTest::TestingUtils.resource_file_path('send_code.xml'))
          fake = Minitest::Mock.new
          transmitter_mock = Moceansdk::Modules::Transmitter.new

          fake.expect :call, transmitter_mock.format_response(file_content, true, '/verify/req'), [String, String, Hash]
          transmitter_mock.stub(:request_and_parse_body, lambda {|method, uri, params|
            assert_equal method, 'post'
            assert_equal uri, '/verify/req'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)
            res = client.verify_request.send(
                'mocean-to': 'test to', 'mocean-brand': 'test-brand'
            )

            assert_equal res.to_s, file_content
            object_test(res)
          end

          assert fake.verify
        end

        private

        def object_test(verify_request_response)
          assert_equal verify_request_response.to_hash, verify_request_response.inspect
          assert_equal verify_request_response.status, '0'
          assert_equal verify_request_response.reqid, 'CPASS_restapi_C0000002737000000.0002'
        end
      end

    end
  end
end