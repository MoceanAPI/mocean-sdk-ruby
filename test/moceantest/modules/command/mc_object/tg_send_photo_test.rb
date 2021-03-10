require_relative '../../../mocean_testing'
module Moceansdk
  module Modules
    module Command
      module McObject

        class TgSendPhotoTest < MoceanTest::Test
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
                  'type': 'photo',
                  'rich_media_url': 'test url',
                  'text': 'test text'
                },
                'action': 'send-telegram'
            }
            assert_equal params, TgSendPhoto.new(params).get_request_data

            tg_send_photo_test = TgSendPhoto.new
            tg_send_photo_test.from 'test bot'
            tg_send_photo_test.to 'test chat'
            tg_send_photo_test.content 'test url', 'test text'

            assert_equal params, tg_send_photo_test.get_request_data
          end

          def test_if_required_field_not_set
            assert_raises Moceansdk::Exceptions::RequiredFieldException do
              TgSendPhoto.new.get_request_data
            end
          end
        end

      end
    end
  end
end