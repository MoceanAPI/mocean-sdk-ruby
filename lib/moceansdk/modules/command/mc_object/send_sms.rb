module Moceansdk
  module Modules
    module Command
      module McObject

        class SendSMS < AbstractMc
          def action
            'send-sms'
          end

          def required_key
            ['from','to','content']
          end

          def from(from, contact_type = 'phone_num')
            @params[:'from'] = {}
            @params[:'from'][:'id'] = from
            @params[:'from'][:'type'] = contact_type
            return self
          end

          def to(to, contact_type = "phone_num")
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

        end

      end
    end
  end
end