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

        def test_json_call
          MoceanTest::TestingUtils.mock_http_request('/voice/dial') do |request|
            assert_equal request.method, :post
            verify_params_with(request.body, {'mocean-to': 'test to', 'mocean-command': 'test mocean command'})
            file_response('voice.json')
          end

          client = MoceanTest::TestingUtils.client_obj
          res = client.voice.call('mocean-to': 'test to', 'mocean-command': 'test mocean command')
          object_test(res)
        end

        def test_xml_call
          MoceanTest::TestingUtils.mock_http_request('/voice/dial') do |request|
            assert_equal request.method, :post
            verify_params_with(request.body, {'mocean-to': 'test to', 'mocean-command': 'test mocean command'})
            file_response('voice.xml')
          end

          client = MoceanTest::TestingUtils.client_obj
          res = client.voice.call('mocean-to': 'test to', 'mocean-command': 'test mocean command', 'mocean-resp-format': 'xml')
          object_test(res)
        end

        def test_json_hangup
          MoceanTest::TestingUtils.mock_http_request('/voice/hangup') do |request|
            assert_equal request.method, :post
            verify_params_with(request.body, {'mocean-call-uuid': 'xxx-xxx-xxx-xxx'})
            file_response('hangup.json')
          end

          client = MoceanTest::TestingUtils.client_obj
          res = client.voice.hangup('xxx-xxx-xxx-xxx')
          assert_equal res.status, '0'
        end

        def test_xml_hangup
          MoceanTest::TestingUtils.mock_http_request('/voice/hangup') do |request|
            assert_equal request.method, :post
            verify_params_with(request.body, {'mocean-call-uuid': 'xxx-xxx-xxx-xxx'})
            file_response('hangup.xml')
          end

          client = MoceanTest::TestingUtils.client_obj
          res = client.voice.hangup('xxx-xxx-xxx-xxx')
          assert_equal res.status, '0'
        end

        def test_required_param_missing
          MoceanTest::TestingUtils.mock_http_request('/voice/dial') do
            file_response('voice.json')
          end

          assert_raises Moceansdk::Exceptions::RequiredFieldException do
            MoceanTest::TestingUtils.client_obj.voice.call
          end
        end

        private

        def object_test(voice_response)
          assert_equal voice_response.to_hash, voice_response.inspect
          assert_equal voice_response.calls[0].status, '0'
          assert_equal voice_response.calls[0].receiver, '60123456789'
          assert_equal voice_response.calls[0]['session_uuid'], 'xxx-xxx-xxx-xxx'
          assert_equal voice_response.calls[0]['call_uuid'], 'xxx-xxx-xxx-xxx'
        end
      end

    end
  end
end