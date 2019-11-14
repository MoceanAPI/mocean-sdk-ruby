require_relative '../../mocean_testing'
module Moceansdk
  module Modules
    module Message

      class SmsTest < MoceanTest::Test
        def test_setter
          sms = MoceanTest::TestingUtils.client_obj.sms

          sms.from = 'test from'
          refute sms.params['mocean-from'].nil?
          assert_equal 'test from', sms.params['mocean-from']

          sms.to = 'test to'
          refute sms.params['mocean-to'].nil?
          assert_equal 'test to', sms.params['mocean-to']

          sms.text = 'test text'
          refute sms.params['mocean-text'].nil?
          assert_equal 'test text', sms.params['mocean-text']

          sms.udh = 'test udh'
          refute sms.params['mocean-udh'].nil?
          assert_equal 'test udh', sms.params['mocean-udh']

          sms.coding = 'test coding'
          refute sms.params['mocean-coding'].nil?
          assert_equal 'test coding', sms.params['mocean-coding']

          sms.dlr_mask = 'test dlr mask'
          refute sms.params['mocean-dlr-mask'].nil?
          assert_equal 'test dlr mask', sms.params['mocean-dlr-mask']

          sms.dlr_url = 'test dlr url'
          refute sms.params['mocean-dlr-url'].nil?
          assert_equal 'test dlr url', sms.params['mocean-dlr-url']

          sms.schedule = '2019-02-01'
          refute sms.params['mocean-schedule'].nil?
          assert_equal '2019-02-01', sms.params['mocean-schedule']

          sms.mclass = 'test mclass'
          refute sms.params['mocean-mclass'].nil?
          assert_equal 'test mclass', sms.params['mocean-mclass']

          sms.alt_dcs = 'test alt dcs'
          refute sms.params['mocean-alt-dcs'].nil?
          assert_equal 'test alt dcs', sms.params['mocean-alt-dcs']

          sms.charset = 'test charset'
          refute sms.params['mocean-charset'].nil?
          assert_equal 'test charset', sms.params['mocean-charset']

          sms.validity = 'test validity'
          refute sms.params['mocean-validity'].nil?
          assert_equal 'test validity', sms.params['mocean-validity']

          sms.resp_format = 'json'
          refute sms.params['mocean-resp-format'].nil?
          assert_equal 'json', sms.params['mocean-resp-format']
        end

        def test_send_flash_sms
          MoceanTest::TestingUtils.mock_http_request('/sms') do |request|
            assert_equal request.method, :post
            verify_params_with(request.body, {'mocean-from': 'test from', 'mocean-to': 'test to', 'mocean-text': 'test text', 'mocean-mclass': '1', 'mocean-alt-dcs': '1'})
            file_response('message.json')
          end

          client = MoceanTest::TestingUtils.client_obj
          client.flash_sms.send('mocean-from': 'test from', 'mocean-to': 'test to', 'mocean-text': 'test text')
        end

        def test_xml_send
          MoceanTest::TestingUtils.mock_http_request('/sms', '1') do |request|
            assert_equal request.method, :post
            verify_params_with(request.body, {'mocean-from': 'test from', 'mocean-to': 'test to', 'mocean-text': 'test text'})
            file_response('message.xml')
          end

          client = MoceanTest::TestingUtils.client_obj(Moceansdk::Modules::Transmitter.new(version: '1'))
          res = client.sms.send('mocean-from': 'test from', 'mocean-to': 'test to', 'mocean-text': 'test text', 'mocean-resp-format': 'xml')
          object_test(res)

          # v2 test
          MoceanTest::TestingUtils.mock_http_request('/sms') do |request|
            assert_equal request.method, :post
            verify_params_with(request.body, {'mocean-from': 'test from', 'mocean-to': 'test to', 'mocean-text': 'test text'})
            file_response('message_v2.xml')
          end

          client = MoceanTest::TestingUtils.client_obj
          res = client.sms.send('mocean-from': 'test from', 'mocean-to': 'test to', 'mocean-text': 'test text', 'mocean-resp-format': 'xml')
          object_test(res)
        end

        def test_json_send
          MoceanTest::TestingUtils.mock_http_request('/sms') do |request|
            assert_equal request.method, :post
            verify_params_with(request.body, {'mocean-from': 'test from', 'mocean-to': 'test to', 'mocean-text': 'test text'})
            file_response('message.json')
          end

          client = MoceanTest::TestingUtils.client_obj
          res = client.sms.send('mocean-from': 'test from', 'mocean-to': 'test to', 'mocean-text': 'test text')
          object_test(res)
        end

        def test_required_param_missing
          MoceanTest::TestingUtils.mock_http_request('/sms') do
            file_response('message.json')
          end

          assert_raises Moceansdk::Exceptions::RequiredFieldException do
            MoceanTest::TestingUtils.client_obj.sms.send
          end
        end

        private

        def object_test(sms_response)
          assert_equal sms_response.to_hash, sms_response.inspect
          assert_equal sms_response.messages[0].status, '0'
          assert_equal sms_response.messages[0].receiver, '60123456789'
          assert_equal sms_response.messages[0].msgid, 'CPASS_restapi_C0000002737000000.0001'
        end
      end

    end
  end
end