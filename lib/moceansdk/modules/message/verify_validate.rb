module Moceansdk
  module Modules
    module Message

      class VerifyValidate < Moceansdk::Modules::AbstractClient
        def initialize(obj_auth, transmitter)
          super(obj_auth, transmitter)
          @required_fields = ['mocean-api-key', 'mocean-api-secret', 'mocean-reqid', 'mocean-code']
        end

        def reqid=(param)
          @params['mocean-reqid'] = param
        end

        def code=(param)
          @params['mocean-code'] = param
        end

        def resp_format=(param)
          @params['mocean-resp-format'] = param
        end

        def send(params = {})
          create(params)
          create_final_params
          required_field_set?

          @transmitter.post('/verify/check', @params)
        end
      end

    end
  end
end