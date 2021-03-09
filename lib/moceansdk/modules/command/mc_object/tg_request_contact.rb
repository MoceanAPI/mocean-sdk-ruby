module Moceansdk
  module Modules
    module Command
      module McObject

        class TgRequestContact < AbstractMc
          def initialize(params=nil)
            super(params)
            button("Share contact")
          end

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

          def content(text)
            @params[:'content'] = {}
            @params[:'content'][:'text'] = text
            @params[:'content'][:'type'] = 'text'
            return self
          end

          def button(text)
            @params[:'tg_keyboard'] = {
              :'button_text' => text,
              :'button_request' => 'contact'
            }
            return self
          end

        end

      end
    end
  end
end