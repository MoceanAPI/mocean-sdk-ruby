require_relative '../../mocean_testing'
module Moceansdk
  module Modules
    module Message

      class VerifyRequestTest < MoceanTest::Test
        def test_setter
          verify_request = MoceanTest::TestingUtils.client_obj.verify_request

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

        def test_send_as_sms_channel
          MoceanTest::TestingUtils.intercept_http_request(
              'send_code.json',
              '/verify/req/sms'
          ) do |method, uri|
            assert_equal method, :post
            assert_equal uri.path, MoceanTest::TestingUtils.test_uri('/verify/req/sms')
          end

          client = MoceanTest::TestingUtils.client_obj
          verify_request = client.verify_request
          assert_equal verify_request.channel, Channel::AUTO
          verify_request.send_as Channel::SMS
          assert_equal verify_request.channel, Channel::SMS
          res = verify_request.send(
              'mocean-to': 'test to', 'mocean-brand': 'test-brand'
          )

          assert_equal res.to_s, MoceanTest::TestingUtils.response_str('send_code.json')
          object_test(res)
        end

        def test_resend
          MoceanTest::TestingUtils.intercept_http_request(
              'resend_code.json',
              '/verify/resend/sms'
          ) do |method, uri|
            assert_equal method, :post
            assert_equal uri.path, MoceanTest::TestingUtils.test_uri('/verify/resend/sms')
          end

          client = MoceanTest::TestingUtils.client_obj
          res = client.verify_request.resend(
              'mocean-reqid': 'test reqid'
          )

          assert_equal res.to_s, MoceanTest::TestingUtils.response_str('resend_code.json')
          object_test(res)
          assert_equal res.to, '60123456789'
          assert_equal res.resend_number, '1'
        end

        def test_json_send
          MoceanTest::TestingUtils.intercept_http_request(
              'send_code.json',
              '/verify/req'
          ) do |method, uri|
            assert_equal method, :post
            assert_equal uri.path, MoceanTest::TestingUtils.test_uri('/verify/req')
          end

          client = MoceanTest::TestingUtils.client_obj
          res = client.verify_request.send(
              'mocean-to': 'test to', 'mocean-brand': 'test-brand'
          )

          assert_equal res.to_s, MoceanTest::TestingUtils.response_str('send_code.json')
          object_test(res)
        end

        def test_xml_send
          MoceanTest::TestingUtils.intercept_http_request(
              'send_code.xml',
              '/verify/req'
          ) do |method, uri|
            assert_equal method, :post
            assert_equal uri.path, MoceanTest::TestingUtils.test_uri('/verify/req')
          end

          client = MoceanTest::TestingUtils.client_obj
          res = client.verify_request.send(
              'mocean-to': 'test to', 'mocean-brand': 'test-brand', 'mocean-resp-format': 'xml'
          )

          assert_equal res.to_s, MoceanTest::TestingUtils.response_str('send_code.xml')
          object_test(res)
        end

        def test_required_field_not_set
          MoceanTest::TestingUtils.intercept_http_request(
              'send_code.json',
              '/verify/req'
          )

          client = MoceanTest::TestingUtils.client_obj
          assert_raises Moceansdk::Exceptions::RequiredFieldException do
            client.verify_request.send
          end
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