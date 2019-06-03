module Moceansdk
  module Modules
    module Message

      class MessageStatus < Moceansdk::Modules::AbstractClient
        def initialize(obj_auth, transmitter)
          super(obj_auth, transmitter)
          @required_fields = ['mocean-api-key', 'mocean-api-secret', 'mocean-msgid']
        end

        def msgid=(param)
          @params['mocean-msgid'] = param
        end

        def resp_format=(param)
          @params['mocean-resp-format'] = param
        end

        def inquiry(params = {})
          create(params)
          create_final_params
          required_field_set?

          @transmitter.get('/report/message', @params)
        end
      end

    end
  end
end