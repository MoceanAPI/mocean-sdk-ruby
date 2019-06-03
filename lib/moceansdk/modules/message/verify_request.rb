module Moceansdk
  module Modules
    module Message

      class VerifyRequest < Moceansdk::Modules::AbstractClient
        def initialize(obj_auth, transmitter)
          super(obj_auth, transmitter)
          @required_fields = ['mocean-api-key', 'mocean-api-secret', 'mocean-to', 'mocean-brand']
          @charge_type = ChargeType::CHARGE_PER_CONVERSION
        end

        def to=(param)
          @params['mocean-to'] = param
        end

        def brand=(param)
          @params['mocean-brand'] = param
        end

        def from=(param)
          @params['mocean-from'] = param
        end

        def code_length=(param)
          @params['mocean-code-length'] = param
        end

        def template=(param)
          @params['mocean-template'] = param
        end

        def pin_validity=(param)
          @params['mocean-pin-validity'] = param
        end

        def next_event_wait=(param)
          @params['mocean-next-event-wait'] = param
        end

        def resp_format=(param)
          @params['mocean-resp-format'] = param
        end

        def send_as(charge_type)
          @charge_type = charge_type
          self
        end

        def send(params = {})
          create(params)
          create_final_params
          required_field_set?

          @verify_request_url = '/verify/req'
          if @charge_type == ChargeType::CHARGE_PER_ATTEMPT
            @verify_request_url += '/sms'
          end

          @transmitter.post(@verify_request_url, @params)
        end
      end

    end
  end
end