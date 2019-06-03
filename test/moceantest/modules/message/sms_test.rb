require_relative '../../mocean_testing'
module Moceansdk
  module Modules
    module Message

      class SmsTest < MoceanTest::Test
        def setup
          @client = MoceanTest::TestingUtils.client_obj
        end

        def test_setter
          sms = @client.sms

          sms.from = 'test from'
          assert sms.params['mocean-from'] != nil
          assert_equal 'test from', sms.params['mocean-from']

          sms.to = 'test to'
          assert sms.params['mocean-to'] != nil
          assert_equal 'test to', sms.params['mocean-to']

          sms.text = 'test text'
          assert sms.params['mocean-text'] != nil
          assert_equal 'test text', sms.params['mocean-text']

          sms.udh = 'test udh'
          assert sms.params['mocean-udh'] != nil
          assert_equal 'test udh', sms.params['mocean-udh']

          sms.coding = 'test coding'
          assert sms.params['mocean-coding'] != nil
          assert_equal 'test coding', sms.params['mocean-coding']

          sms.dlr_mask = 'test dlr mask'
          assert sms.params['mocean-dlr-mask'] != nil
          assert_equal 'test dlr mask', sms.params['mocean-dlr-mask']

          sms.dlr_url = 'test dlr url'
          assert sms.params['mocean-dlr-url'] != nil
          assert_equal 'test dlr url', sms.params['mocean-dlr-url']

          sms.schedule = '2019-02-01'
          assert sms.params['mocean-schedule'] != nil
          assert_equal '2019-02-01', sms.params['mocean-schedule']

          sms.mclass = 'test mclass'
          assert sms.params['mocean-mclass'] != nil
          assert_equal 'test mclass', sms.params['mocean-mclass']

          sms.alt_dcs = 'test alt dcs'
          assert sms.params['mocean-alt-dcs'] != nil
          assert_equal 'test alt dcs', sms.params['mocean-alt-dcs']

          sms.charset = 'test charset'
          assert sms.params['mocean-charset'] != nil
          assert_equal 'test charset', sms.params['mocean-charset']

          sms.validity = 'test validity'
          assert sms.params['mocean-validity'] != nil
          assert_equal 'test validity', sms.params['mocean-validity']

          sms.resp_format = 'json'
          assert sms.params['mocean-resp-format'] != nil
          assert_equal 'json', sms.params['mocean-resp-format']
        end

        def test_send
          fake = Minitest::Mock.new
          fake.expect :call, 'testing only', [String, String, Hash]

          transmitter_mock = Moceansdk::Modules::Transmitter.new
          transmitter_mock.stub(:request, lambda {|method, uri, params|
            assert_equal method, 'post'
            assert_equal uri, '/sms'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)
            assert_equal(client.sms.send(
                'mocean-from': 'test from', 'mocean-to': 'test to', 'mocean-text': 'test text'
            ), 'testing only')
          end

          assert fake.verify
        end

        def test_json_response
          file_content = File.read(MoceanTest::TestingUtils.resource_file_path('message.json'))
          fake = Minitest::Mock.new
          fake.expect :call, Moceansdk::Modules::Transmitter.new.format_response(file_content), [String, String, Hash]

          transmitter_mock = Moceansdk::Modules::Transmitter.new
          transmitter_mock.stub(:request, lambda {|method, uri, params|
            assert_equal method, 'post'
            assert_equal uri, '/sms'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)
            res = client.sms.send(
                'mocean-from': 'test from', 'mocean-to': 'test to', 'mocean-text': 'test text'
            )

            assert_equal res.to_s, file_content
            object_test(res)
          end

          assert fake.verify
        end

        def test_xml_response
          file_content = File.read(MoceanTest::TestingUtils.resource_file_path('message.xml'))
          fake = Minitest::Mock.new
          fake.expect :call, Moceansdk::Modules::Transmitter.new.format_response(file_content, true, '/sms'), [String, String, Hash]

          transmitter_mock = Moceansdk::Modules::Transmitter.new
          transmitter_mock.stub(:request, lambda {|method, uri, params|
            assert_equal method, 'post'
            assert_equal uri, '/sms'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)
            res = client.sms.send(
                'mocean-from': 'test from', 'mocean-to': 'test to', 'mocean-text': 'test text'
            )

            assert_equal res.to_s, file_content
            object_test(res)
          end

          assert fake.verify
        end

        private

        def object_test(sms_response)
          assert_equal sms_response.messages[0].status, '0'
          assert_equal sms_response.messages[0].receiver, '60123456789'
          assert_equal sms_response.messages[0].msgid, 'CPASS_restapi_C0000002737000000.0001'
        end
      end

    end
  end
end