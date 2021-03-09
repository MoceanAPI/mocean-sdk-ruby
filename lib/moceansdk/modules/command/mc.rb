module Moceansdk
  module Modules
    module Command

      class Mc
        def self.tg_send_text()
          McObject::TgSendText.new
        end

        def self.tg_send_audio()
          McObject::TgSendAudio.new
        end

        def self.tg_send_animation()
          McObject::TgSendAnimation.new
        end

        def self.tg_send_document()
          McObject::TgSendDocument.new
        end

        def self.tg_send_photo()
          McObject::TgSendPhoto.new
        end

        def self.tg_send_video()
          McObject::TgSendVideo.new
        end

        def self.tg_request_contact()
          McObject::TgRequestContact.new
        end

        def self.send_sms()
          McObject::SendSMS.new
        end
      end
    end
  end
end