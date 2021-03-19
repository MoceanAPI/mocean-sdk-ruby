require_relative '../../mocean_testing'
module Moceansdk
  module Modules
    module Command

      class CommandTest < MoceanTest::Test
        def test_command_setter
          command = MoceanTest::TestingUtils.client_obj.command

          command.event_url = 'test event url'
          refute command.params['mocean-event-url'].nil?
          assert_equal 'test event url', command.params['mocean-event-url']

          command.mocean_command = 'test mocean command'
          refute command.params['mocean-command'].nil?
          assert_equal 'test mocean command', command.params['mocean-command']

          # test multiple mocean commands
          command = MoceanTest::TestingUtils.client_obj.command
          command.mocean_command = [{'action': 'send-telegram'}]
          refute command.params['mocean-command'].nil?
          assert_equal JSON.generate([{'action': 'send-telegram'}]), command.params['mocean-command']

          command = MoceanTest::TestingUtils.client_obj.command
          builder_params = McBuilder.new.add(Mc.tg_send_text.from("moceantestbot").to("813260944").content("hello world"))
          command.mocean_command = builder_params
          refute command.params['mocean-command'].nil?
          assert_equal JSON.generate(builder_params.build), command.params['mocean-command']

          command = MoceanTest::TestingUtils.client_obj.command
          builder_params = Mc.tg_send_text.from("moceantestbot").to("813260944").content("hello world")
          command.mocean_command = builder_params
          refute command.params['mocean-command'].nil?
          assert_equal JSON.generate(McBuilder.new.add(builder_params).build), command.params['mocean-command']
        end

        def test_json_req
          MoceanTest::TestingUtils.mock_http_request('/send-message') do |request|
            assert_equal request.method, :post
            verify_params_with(request.body, {'mocean-command': 'test mocean command'})
            file_response('send_message.json')
          end

          client = MoceanTest::TestingUtils.client_obj
          res = client.command.execute('mocean-command': 'test mocean command')
          object_test(res)
        end

        def test_command_required_param_missing
          MoceanTest::TestingUtils.mock_http_request('/send-message') do
            file_response('send_message.json')
          end

          assert_raises Moceansdk::Exceptions::RequiredFieldException do
            MoceanTest::TestingUtils.client_obj.command.execute
          end
        end

        private

        def object_test(command_response)
          assert_equal command_response.to_hash, command_response.inspect
          assert_equal command_response.status, '0'
          assert_equal command_response['session-uuid'], 'xxxxxx'
          assert_equal command_response['mocean-command-resp'][0].action, 'xxxx-xxxx'
          assert_equal command_response['mocean-command-resp'][0]['message-id'], 'xxxxxx'
          assert_equal command_response['mocean-command-resp'][0]['mc-position'], '0'
          assert_equal command_response['mocean-command-resp'][0]['total-message-segments'], '1'
        end
      end

    end
  end
end