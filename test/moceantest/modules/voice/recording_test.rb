require_relative '../../mocean_testing'
module Moceansdk
  module Modules
    module Voice

      class RecordingTest < MoceanTest::Test
        def test_json_recording
          MoceanTest::TestingUtils.mock_http_request('/voice/rec') do |request|
            assert_equal request.method, :get
            verify_params_with(request.body, {'mocean-call-uuid': 'xxx-xxx-xxx-xxx'})
            response = file_response('recording.json')
            response['headers'] = {'Content-Type': 'audio/mpeg'}
            response
          end

          client = MoceanTest::TestingUtils.client_obj
          res = client.voice.recording('xxx-xxx-xxx-xxx')
          refute res.recording_buffer.nil?
          assert_equal res.filename, 'xxx-xxx-xxx-xxx.mp3'
        end

        def test_error_recording
          MoceanTest::TestingUtils.mock_http_request('/voice/rec') do
            file_response('error_response.json')
          end

          client = MoceanTest::TestingUtils.client_obj

          assert_raises Moceansdk::Exceptions::MoceanError do
            client.voice.recording('xxx-xxx-xxx-xxx')
          end
        end
      end

    end
  end
end