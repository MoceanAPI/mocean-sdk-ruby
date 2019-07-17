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

        def call_event_url=(param)
          @params['mocean-call-event-url'] = param
        end

        def call_control_commands=(param)
          if param.is_a? McccBuilder
            @params['mocean-call-control-commands'] = JSON.generate(param.build)
          elsif param.is_a? McccObject::AbstractMccc
            @params['mocean-call-control-commands'] = JSON.generate([param.get_request_data])
          elsif param.is_a? Array
            @params['mocean-call-control-commands'] = JSON.generate(param)
          else
            @params['mocean-call-control-commands'] = param
          end
        end

        def resp_format=(param)
          @params['mocean-resp-format'] = param
        end

        def call(params = {})
          sym_params = Moceansdk::Utils.convert_to_symbol_hash(params)

          unless sym_params[:'mocean-call-control-commands'].nil?
            mccc = sym_params[:'mocean-call-control-commands']
            sym_params.delete(:'mocean-call-control-commands')
            self.call_control_commands = mccc
          end

          create(sym_params)
          create_final_params
          required_field_set?

          @transmitter.get('/voice/dial', @params)
        end
      end

    end
  end
end
