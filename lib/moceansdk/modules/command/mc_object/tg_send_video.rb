module Moceansdk
  module Modules
    module Command
      module McObject

        class TgSendVideo < AbstractMc
          def action
            'send-telegram'
          end

          def required_key
            ['from','to','content']
          end

          def from(from, contact_type = 'bot_username')
            @params[:'from'] = {}
            @params[:'from'][:'id'] = from
            @params[:'from'][:'type'] = contact_type
            return self
          end

          def to(to, contact_type = "chat_id")
            @params[:'to'] = {}
            @params[:'to'][:'id'] = to
            @params[:'to'][:'type'] = contact_type
            return self
          end

          def content(url,text)
            @params[:'content'] = {}
            @params[:'content'][:'rich_media_url'] = url
            @params[:'content'][:'text'] = text
            @params[:'content'][:'type'] = 'video'
            return self
          end
        end

      end
    end
  end
end