module Moceansdk
  module Modules
    module Message

      class VerifyRequest < Moceansdk::Modules::AbstractClient
        attr_reader :channel, :is_resend

        def initialize(obj_auth, transmitter)
          super(obj_auth, transmitter)
          @required_fields = ['mocean-api-key', 'mocean-api-secret', 'mocean-to', 'mocean-brand']
          @channel = Channel::AUTO
          @is_resend = false
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

        def send_as(channel)
          @channel = channel
          self
        end

        def send(params = {})
          create(params)
          create_final_params
          required_field_set?

          verify_request_url = '/verify'
          verify_request_url += if @is_resend
                                  '/resend'
                                else
                                  '/req'
                                end

          if @channel == Channel::SMS
            verify_request_url += '/sms'
          end

          @transmitter.post(verify_request_url, @params)
        end

        def resend(params = {})
          send_as Channel::SMS
          @is_resend = true
          @required_fields = ['mocean-api-key', 'mocean-api-secret', 'mocean-reqid']

          send(params)
        end
      end

    end
  end
end