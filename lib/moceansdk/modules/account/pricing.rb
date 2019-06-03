module Moceansdk
  module Modules
    module Account

      class Pricing < Moceansdk::Modules::AbstractClient
        def initialize(obj_auth, transmitter)
          super(obj_auth, transmitter)
          @required_fields = ['mocean-api-key', 'mocean-api-secret']
        end

        def mcc=(param)
          @params['mocean-mcc'] = param
        end

        def mnc=(param)
          @params['mocean-mnc'] = param
        end

        def delimiter=(param)
          @params['mocean-delimiter'] = param
        end

        def resp_format=(param)
          @params['mocean-resp-format'] = param
        end

        def inquiry(params = {})
          create(params)
          create_final_params
          required_field_set?

          @transmitter.get('/account/pricing', @params)
        end
      end

    end
  end
end