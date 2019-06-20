module Moceansdk
  module Modules
    module NumberLookup

      class NumberLookup < Moceansdk::Modules::AbstractClient
        def initialize(obj_auth, transmitter)
          super(obj_auth, transmitter)
          @required_fields = ['mocean-api-key', 'mocean-api-secret', 'mocean-to']
        end

        def to=(param)
          @params['mocean-to'] = param
        end

        def nl_url=(param)
          @params['mocean-nl-url'] = param
        end

        def resp_format=(param)
          @params['mocean-resp-format'] = param
        end

        def inquiry(params = {})
          create(params)
          create_final_params
          required_field_set?

          @transmitter.post('/nl', @params)
        end
      end

    end
  end
end
