require_relative '../../../mocean_testing'
module Moceansdk
  module Modules
    module Command
      module McObject

        class TgRequestContactTest < MoceanTest::Test
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
                'tg_keyboard': {
                  'button_request': 'contact',
                  'button_text': 'button text'
                },
                'action': 'send-telegram'
            }
            assert_equal params, TgRequestContact.new(params).get_request_data

            tg_request_contact_test = TgRequestContact.new
            tg_request_contact_test.from 'test bot'
            tg_request_contact_test.to 'test chat'
            tg_request_contact_test.content 'test text'
            tg_request_contact_test.button 'button text'

            assert_equal params, tg_request_contact_test.get_request_data
          end

          def test_if_required_field_not_set
            assert_raises Moceansdk::Exceptions::RequiredFieldException do
              TgRequestContact.new.get_request_data
            end
          end
        end

      end
    end
  end
end