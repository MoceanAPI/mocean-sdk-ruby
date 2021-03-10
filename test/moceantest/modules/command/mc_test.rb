require_relative '../../mocean_testing'
module Moceansdk
  module Modules
    module Command

      class McTest < MoceanTest::Test
        def test_mc_send_tg_text
          tg_send_text_test = Mc.tg_send_text

          assert_raises Moceansdk::Exceptions::RequiredFieldException do
            tg_send_text_test.get_request_data
          end

          tg_send_text_test.from 'test bot'
          tg_send_text_test.to 'test chat'
          tg_send_text_test.content 'testing text'
          assert_equal 'testing text', tg_send_text_test.get_request_data[:content][:text]

          assert_equal 'testing text2', tg_send_text_test.content('testing text2').get_request_data[:content][:text]
        end


        def test_mc_send_sms
          send_sms_test = Mc.send_sms

          assert_raises Moceansdk::Exceptions::RequiredFieldException do
            send_sms_test.get_request_data
          end

          send_sms_test.from 'from num'
          send_sms_test.to 'to num'
          send_sms_test.content 'testing text'
          assert_equal 'testing text', send_sms_test.get_request_data[:content][:text]

          assert_equal 'testing text2', send_sms_test.content('testing text2').get_request_data[:content][:text]
        end

        def test_tg_request_contact
          tg_request_contact_test = Mc.tg_request_contact

          assert_raises Moceansdk::Exceptions::RequiredFieldException do
            tg_request_contact_test.get_request_data
          end

          tg_request_contact_test.from 'bot id'
          tg_request_contact_test.to 'chat id'
          tg_request_contact_test.content 'context text'
          tg_request_contact_test.button 'button text'
          assert_equal 'context text', tg_request_contact_test.get_request_data[:content][:text]
          assert_equal 'button text', tg_request_contact_test.get_request_data[:tg_keyboard][:button_text]
          assert_equal 'contact', tg_request_contact_test.get_request_data[:tg_keyboard][:button_request]

          assert_equal 'testing text2', tg_request_contact_test.content('testing text2').get_request_data[:content][:text]
        end

        def test_tg_send_animation
          tg_send_animation_test = Mc.tg_send_animation

          assert_raises Moceansdk::Exceptions::RequiredFieldException do
            tg_send_animation_test.get_request_data
          end

          tg_send_animation_test.from 'bot id'
          tg_send_animation_test.to 'chat id'
          tg_send_animation_test.content 'content url', 'testing text'
          assert_equal 'testing text', tg_send_animation_test.get_request_data[:content][:text]
          assert_equal 'content url', tg_send_animation_test.get_request_data[:content][:rich_media_url]

          assert_equal 'testing text2', tg_send_animation_test.content('content url 2', 'testing text2').get_request_data[:content][:text]
          assert_equal 'content url 3', tg_send_animation_test.content('content url 3', 'testing text3').get_request_data[:content][:rich_media_url]
        end

        def test_tg_send_audio
          tg_send_audio_test = Mc.tg_send_audio

          assert_raises Moceansdk::Exceptions::RequiredFieldException do
            tg_send_audio_test.get_request_data
          end

          tg_send_audio_test.from 'bot id'
          tg_send_audio_test.to 'chat id'
          tg_send_audio_test.content 'content url', 'testing text'
          assert_equal 'testing text', tg_send_audio_test.get_request_data[:content][:text]
          assert_equal 'content url', tg_send_audio_test.get_request_data[:content][:rich_media_url]

          assert_equal 'testing text2', tg_send_audio_test.content('content url 2', 'testing text2').get_request_data[:content][:text]
          assert_equal 'content url 3', tg_send_audio_test.content('content url 3', 'testing text3').get_request_data[:content][:rich_media_url]
        end

        def test_tg_send_document
          tg_send_document_test = Mc.tg_send_document

          assert_raises Moceansdk::Exceptions::RequiredFieldException do
            tg_send_document_test.get_request_data
          end

          tg_send_document_test.from 'bot id'
          tg_send_document_test.to 'chat id'
          tg_send_document_test.content 'content url', 'testing text'
          assert_equal 'testing text', tg_send_document_test.get_request_data[:content][:text]
          assert_equal 'content url', tg_send_document_test.get_request_data[:content][:rich_media_url]

          assert_equal 'testing text2', tg_send_document_test.content('content url 2', 'testing text2').get_request_data[:content][:text]
          assert_equal 'content url 3', tg_send_document_test.content('content url 3', 'testing text3').get_request_data[:content][:rich_media_url]
        end

        def test_tg_send_photo
          tg_send_photo_test = Mc.tg_send_photo

          assert_raises Moceansdk::Exceptions::RequiredFieldException do
            tg_send_photo_test.get_request_data
          end

          tg_send_photo_test.from 'bot id'
          tg_send_photo_test.to 'chat id'
          tg_send_photo_test.content 'content url', 'testing text'
          assert_equal 'testing text', tg_send_photo_test.get_request_data[:content][:text]
          assert_equal 'content url', tg_send_photo_test.get_request_data[:content][:rich_media_url]

          assert_equal 'testing text2', tg_send_photo_test.content('content url 2', 'testing text2').get_request_data[:content][:text]
          assert_equal 'content url 3', tg_send_photo_test.content('content url 3', 'testing text3').get_request_data[:content][:rich_media_url]
        end

        def test_tg_send_video
          tg_send_video_test = Mc.tg_send_video

          assert_raises Moceansdk::Exceptions::RequiredFieldException do
            tg_send_video_test.get_request_data
          end

          tg_send_video_test.from 'bot id'
          tg_send_video_test.to 'chat id'
          tg_send_video_test.content 'content url', 'testing text'
          assert_equal 'testing text', tg_send_video_test.get_request_data[:content][:text]
          assert_equal 'content url', tg_send_video_test.get_request_data[:content][:rich_media_url]

          assert_equal 'testing text2', tg_send_video_test.content('content url 2', 'testing text2').get_request_data[:content][:text]
          assert_equal 'content url 3', tg_send_video_test.content('content url 3', 'testing text3').get_request_data[:content][:rich_media_url]
        end
      end
    end
  end
end
