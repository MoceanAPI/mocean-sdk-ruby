module Moceansdk
  module Modules
    module Voice

      class Voice < Moceansdk::Modules::AbstractClient
        def initialize(obj_auth, transmitter)
          super(obj_auth, transmitter)
          @required_fields = ['mocean-api-key', 'mocean-api-secret', 'mocean-to']
        end

        def to=(param)
          @params['mocean-to'] = param
        end

        def event_url=(param)
          @params['mocean-event-url'] = param
        end

        def mocean_command=(param)
          if param.is_a? McBuilder
            @params['mocean-command'] = JSON.generate(param.build)
          elsif param.is_a? McObject::AbstractMc
            @params['mocean-command'] = JSON.generate([param.get_request_data])
          elsif param.is_a? Array
            @params['mocean-command'] = JSON.generate(param)
          else
            @params['mocean-command'] = param
          end
        end

        def resp_format=(param)
          @params['mocean-resp-format'] = param
        end

        def call(params = {})
          sym_params = Moceansdk::Utils.convert_to_symbol_hash(params)

          unless sym_params[:'mocean-command'].nil?
            mc = sym_params[:'mocean-command']
            sym_params.delete(:'mocean-command')
            self.mocean_command = mc
          end

          create(sym_params)
          create_final_params
          required_field_set?

          @transmitter.post('/voice/dial', @params)
        end

        def hangup(call_uuid)
          @required_fields = ['mocean-api-key', 'mocean-api-secret', 'mocean-call-uuid']

          create({:'mocean-call-uuid' => call_uuid})
          create_final_params
          required_field_set?

          @transmitter.post("/voice/hangup", @params)
        end

        def recording(call_uuid)
          @required_fields = ['mocean-api-key', 'mocean-api-secret', 'mocean-call-uuid']

          create({:'mocean-call-uuid' => call_uuid})
          create_final_params
          required_field_set?

          response = @transmitter.request('get', '/voice/rec', @params)

          if response['Content-Type'] === 'audio/mpeg'
            hashed_res = HashExtended.new.merge({'recording_buffer': response.to_s, 'filename': "#{call_uuid}.mp3"})
            return hashed_res.to_dot
          end

          # this method will raise exception if there's error
          processed_response = Moceansdk::Modules::ResponseFactory.create_object(response.to_s)
          processed_response.raw_response = response.to_s
          raise Moceansdk::Exceptions::MoceanError.new(processed_response['err_msg'], processed_response)
        end
      end

    end
  end
end
