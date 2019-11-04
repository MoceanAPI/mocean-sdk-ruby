require_relative '../../mocean_testing'
module Moceansdk
  module Modules
    module Voice

      class VoiceTest < MoceanTest::Test
        def setup
          @client = MoceanTest::TestingUtils.client_obj
        end

        def test_setter
          voice = @client.voice

          voice.to = 'test to'
          refute voice.params['mocean-to'].nil?
          assert_equal 'test to', voice.params['mocean-to']

          voice.call_event_url = 'test call event url'
          refute voice.params['mocean-call-event-url'].nil?
          assert_equal 'test call event url', voice.params['mocean-call-event-url']

          voice.call_control_commands = 'test call control commands'
          refute voice.params['mocean-call-control-commands'].nil?
          assert_equal 'test call control commands', voice.params['mocean-call-control-commands']

          voice.resp_format = 'json'
          refute voice.params['mocean-resp-format'].nil?
          assert_equal 'json', voice.params['mocean-resp-format']

          # test multiple call control commands
          voice = @client.voice
          voice.call_control_commands = [{'action': 'say'}]
          refute voice.params['mocean-call-control-commands'].nil?
          assert_equal JSON.generate([{'action': 'say'}]), voice.params['mocean-call-control-commands']

          voice = @client.voice
          builder_params = McccBuilder.new.add(Mccc.say 'hello world')
          voice.call_control_commands = builder_params
          refute voice.params['mocean-call-control-commands'].nil?
          assert_equal JSON.generate(builder_params.build), voice.params['mocean-call-control-commands']

          voice = @client.voice
          mccc_params = Mccc.say('hello world')
          voice.call_control_commands = mccc_params
          refute voice.params['mocean-call-control-commands'].nil?
          assert_equal JSON.generate(McccBuilder.new.add(mccc_params).build), voice.params['mocean-call-control-commands']
        end

        def test_call
          fake = Minitest::Mock.new
          fake.expect :call, 'testing only', [String, String, Hash]

          transmitter_mock = Moceansdk::Modules::Transmitter.new
          transmitter_mock.stub(:request, lambda {|method, uri, params|
            assert_equal method, 'post'
            assert_equal uri, '/voice/dial'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)

            assert_raises Moceansdk::Exceptions::RequiredFieldException do
              client.voice.call
            end

            assert_equal client.voice.call('mocean-to': 'test to', 'mocean-call-control-commands': 'test call control commands'), 'testing only'
          end

          assert fake.verify
        end

        def test_json_response
          file_content = File.read(MoceanTest::TestingUtils.resource_file_path('voice.json'))
          fake = Minitest::Mock.new
          transmitter_mock = Moceansdk::Modules::Transmitter.new

          fake.expect :call, transmitter_mock.format_response(file_content), [String, String, Hash]
          transmitter_mock.stub(:request, lambda {|method, uri, params|
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
          transmitter_mock.stub(:request, lambda {|method, uri, params|
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
          transmitter_mock.stub(:request, lambda {|method, uri, params|
            assert_equal method, 'post'
            assert_equal uri, '/voice/hangup/xxx-xxx-xxx-xxx'
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
          transmitter_mock.stub(:request, lambda {|method, uri, params|
            assert_equal method, 'post'
            assert_equal uri, '/voice/hangup/xxx-xxx-xxx-xxx'
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