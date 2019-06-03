module Moceansdk
  module Modules
    module Message

      class Sms < AbstractClient
        def initialize(obj_auth, transmitter)
          super(obj_auth, transmitter)
          @required_fields = ['mocean-api-key', 'mocean-api-secret', 'mocean-from', 'mocean-to', 'mocean-text']
        end

        def from=(param)
          @params['mocean-from'] = param
        end

        def to=(param)
          @params['mocean-to'] = param
        end

        def text=(param)
          @params['mocean-text'] = param
        end

        def udh=(param)
          @params['mocean-udh'] = param
        end

        def coding=(param)
          @params['mocean-coding'] = param
        end

        def dlr_mask=(param)
          @params['mocean-dlr-mask'] = param
        end

        def dlr_url=(param)
          @params['mocean-dlr-url'] = param
        end

        def schedule=(param)
          @params['mocean-schedule'] = param
        end

        def mclass=(param)
          @params['mocean-mclass'] = param
        end

        def alt_dcs=(param)
          @params['mocean-alt-dcs'] = param
        end

        def charset=(param)
          @params['mocean-charset'] = param
        end

        def validity=(param)
          @params['mocean-validity'] = param
        end

        def resp_format=(param)
          @params['mocean-resp-format'] = param
        end

        def send(params = {})
          create(params)
          create_final_params
          required_field_set?

          @transmitter.post('/sms', @params)
        end
      end

    end
  end
end
