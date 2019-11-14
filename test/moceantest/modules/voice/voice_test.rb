require_relative '../../mocean_testing'
module Moceansdk
  module Modules
    module Voice

      class VoiceTest < MoceanTest::Test
        def test_setter
          voice = MoceanTest::TestingUtils.client_obj.voice

          voice.to = 'test to'
          refute voice.params['mocean-to'].nil?
          assert_equal 'test to', voice.params['mocean-to']

          voice.event_url = 'test event url'
          refute voice.params['mocean-event-url'].nil?
          assert_equal 'test event url', voice.params['mocean-event-url']

          voice.mocean_command = 'test mocean command'
          refute voice.params['mocean-command'].nil?
          assert_equal 'test mocean command', voice.params['mocean-command']

          voice.resp_format = 'json'
          refute voice.params['mocean-resp-format'].nil?
          assert_equal 'json', voice.params['mocean-resp-format']

          # test multiple mocean commands
          voice = MoceanTest::TestingUtils.client_obj.voice
          voice.mocean_command = [{'action': 'say'}]
          refute voice.params['mocean-command'].nil?
          assert_equal JSON.generate([{'action': 'say'}]), voice.params['mocean-command']

          voice = MoceanTest::TestingUtils.client_obj.voice
          builder_params = McBuilder.new.add(Mc.say 'hello world')
          voice.mocean_command = builder_params
          refute voice.params['mocean-command'].nil?
          assert_equal JSON.generate(builder_params.build), voice.params['mocean-command']

          voice = MoceanTest::TestingUtils.client_obj.voice
          mc_params = Mc.say('hello world')
          voice.mocean_command = mc_params
          refute voice.params['mocean-command'].nil?
          assert_equal JSON.generate(McBuilder.new.add(mc_params).build), voice.params['mocean-command']
        end

        def test_call
          fake = Minitest::Mock.new
          fake.expect :call, 'testing only', [String, String, Hash]

          transmitter_mock = Moceansdk::Modules::Transmitter.new
          transmitter_mock.stub(:request_and_parse_body, lambda {|method, uri, params|
            assert_equal method, 'post'
            assert_equal uri, '/voice/dial'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)

            assert_raises Moceansdk::Exceptions::RequiredFieldException do
              client.voice.call
            end

            assert_equal client.voice.call('mocean-to': 'test to', 'mocean-command': 'test mocean command'), 'testing only'
          end

          assert fake.verify
        end

        def test_json_response
          file_content = File.read(MoceanTest::TestingUtils.resource_file_path('voice.json'))
          fake = Minitest::Mock.new
          transmitter_mock = Moceansdk::Modules::Transmitter.new

          fake.expect :call, transmitter_mock.format_response(file_content), [String, String, Hash]
          transmitter_mock.stub(:request_and_parse_body, lambda {|method, uri, params|
            assert_equal method, 'post'
            assert_equal uri, '/voice/dial'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)
            res = client.voice.call('mocean-to': 'test to')

            assert_equal res.to_s, file_content
            object_test(res)
          end

          assert fake.verify
        end

        def test_xml_response
          file_content = File.read(MoceanTest::TestingUtils.resource_file_path('voice.xml'))
          fake = Minitest::Mock.new
          fake.expect :call, Moceansdk::Modules::Transmitter.new.format_response(file_content, true, '/voice/dial'), [String, String, Hash]

          transmitter_mock = Moceansdk::Modules::Transmitter.new
          transmitter_mock.stub(:request_and_parse_body, lambda {|method, uri, params|
            assert_equal method, 'post'
            assert_equal uri, '/voice/dial'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)
            res = client.voice.call('mocean-to': 'test to')

            assert_equal res.to_s, file_content
            object_test(res)
          end

          assert fake.verify
        end

        def test_json_hangup
          file_content = File.read(MoceanTest::TestingUtils.resource_file_path('hangup.json'))
          fake = Minitest::Mock.new
          transmitter_mock = Moceansdk::Modules::Transmitter.new

          fake.expect :call, transmitter_mock.format_response(file_content), [String, String, Hash]
          transmitter_mock.stub(:request_and_parse_body, lambda {|method, uri, params|
            assert_equal params[:'mocean-call-uuid'], 'xxx-xxx-xxx-xxx'
            assert_equal method, 'post'
            assert_equal uri, '/voice/hangup'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)
            res = client.voice.hangup('xxx-xxx-xxx-xxx')

            assert_equal res.to_s, file_content
            assert_equal res.status, '0'
          end

          assert fake.verify
        end

        def test_xml_hangup
          file_content = File.read(MoceanTest::TestingUtils.resource_file_path('hangup.xml'))
          fake = Minitest::Mock.new
          fake.expect :call, Moceansdk::Modules::Transmitter.new.format_response(file_content, true, '/voice/hangup/xxx-xxx-xxx-xxx'), [String, String, Hash]

          transmitter_mock = Moceansdk::Modules::Transmitter.new
          transmitter_mock.stub(:request_and_parse_body, lambda {|method, uri, params|
            assert_equal params[:'mocean-call-uuid'], 'xxx-xxx-xxx-xxx'
            assert_equal method, 'post'
            assert_equal uri, '/voice/hangup'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)
            res = client.voice.hangup('xxx-xxx-xxx-xxx')

            assert_equal res.to_s, file_content
            assert_equal res.status, '0'
          end

          assert fake.verify
        end

        private

        def object_test(voice_response)
          assert_equal voice_response.to_hash, voice_response.inspect
          assert_equal voice_response.calls[0].status, '0'
          assert_equal voice_response.calls[0].receiver, '60123456789'
          assert_equal voice_response.calls[0]['session-uuid'], 'xxx-xxx-xxx-xxx'
          assert_equal voice_response.calls[0]['call-uuid'], 'xxx-xxx-xxx-xxx'
        end
      end

    end
  end
end