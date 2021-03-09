module Moceansdk
  module Modules
    module Command

      class Command < Moceansdk::Modules::AbstractClient
        def initialize(obj_auth, transmitter)
          super(obj_auth, transmitter)
          @required_fields = ['mocean-api-key', 'mocean-api-secret','mocean-command']
        end

        def event_url=(param)
          @params['mocean-event-url'] = param
        end

        def mocean_command=(param)
          if param.is_a? McBuilder
            @params['mocean-command'] = param.build
          else
            raise Moceansdk::Exceptions::MoceanError.new('mocean_command must be instance of McBuilder')
          end
        end


        def execute(params = {})
          
          if params[:'mocean-command'].nil? == false && (params[:'mocean-command'].is_a? McBuilder) == false
            raise Moceansdk::Exceptions::MoceanError.new('mocean_command must be instance of McBuilder')
          end

          create(params)
          create_final_params
          required_field_set?
          
          @params[:'mocean-command'] = JSON.generate(@params[:'mocean-command'].build)
        
          @transmitter.post('/send-message', @params)
        end

       

        
      end
      
    end
  end
end
