require_relative '../../mocean_testing'
module Moceansdk
  module Modules
    module Voice

      class RecordingTest < MoceanTest::Test
        def setup
          @client = MoceanTest::TestingUtils.client_obj
        end

        def test_json_recording
          file_content = File.read(MoceanTest::TestingUtils.resource_file_path('recording.json'))
          fake = Minitest::Mock.new
          transmitter_mock = Moceansdk::Modules::Transmitter.new

          mock_recording_response = MockRecordingResponse.new
          mock_recording_response['Content-Type'] = 'audio/mpeg'
          mock_recording_response['content'] = file_content

          fake.expect :call, mock_recording_response, [String, String, Hash]
          transmitter_mock.stub(:request, lambda { |method, uri, params|
            assert_equal method, 'get'
            assert_equal uri, '/voice/rec'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)
            res = client.voice.recording('xxx-xxx-xxx-xxx')

            refute res.recording_buffer.nil?
            assert_equal res.filename, 'xxx-xxx-xxx-xxx.mp3'
          end

          assert fake.verify
        end

        def test_error_recording
          file_content = File.read(MoceanTest::TestingUtils.resource_file_path('error_response.json'))
          fake = Minitest::Mock.new
          transmitter_mock = Moceansdk::Modules::Transmitter.new

          mock_recording_response = MockRecordingResponse.new
          mock_recording_response['is_error'] = true
          mock_recording_response['content'] = file_content

          fake.expect :call, mock_recording_response, [String, String, Hash]
          transmitter_mock.stub(:request, lambda { |method, uri, params|
            assert_equal method, 'get'
            assert_equal uri, '/voice/rec'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)

            assert_raises Moceansdk::Exceptions::MoceanError do
              client.voice.recording('xxx-xxx-xxx-xxx')
            end
          end

          assert fake.verify
        end
      end

      class MockRecordingResponse < Hash
        def initialize(*several_variants)
          super(*several_variants)
          self['is_error'] = false
        end

        def to_s
          if self['is_error']
            self['content']
          else
            {'recording_buffer': self['content'], 'filename': "xxx-xxx-xxx-xxx.mp3"}
          end
        end
      end

    end
  end
end