require_relative '../../../mocean_testing'
module Moceansdk
  module Modules
    module Command
      module McObject

        class TgSendTextTest < MoceanTest::Test
          def test_params
            params = {
                'from': {
                  'type': 'bot_username',
                  'id': 'test bot'
                },
                'to':  {
                  'type': 'chat_id',
                  'id': 'test chat'
                },
                'content': {
                  'type': 'text',
                  'text': 'test text'
                },
                'action': 'send-telegram'
            }
            assert_equal params, TgSendText.new(params).get_request_data

            tg_send_text_test = TgSendText.new
            tg_send_text_test.from 'test bot'
            tg_send_text_test.to 'test chat'
            tg_send_text_test.content 'test text'

            assert_equal params, tg_send_text_test.get_request_data
          end

          def test_if_required_field_not_set
            assert_raises Moceansdk::Exceptions::RequiredFieldException do
              TgSendText.new.get_request_data
            end
          end
        end

      end
    end
  end
end