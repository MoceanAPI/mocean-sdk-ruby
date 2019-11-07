module Moceansdk
  module Modules
    module Voice
      module McObject

        class Dial < AbstractMc
          def to=(param)
            @params[:to] = param
          end

          def from=(param)
            @params[:from] = param
          end

          def dial_sequentially=(param)
            @params[:'dial-sequentially'] = param
          end

          def required_key
            ['to']
          end

          def action
            'dial'
          end
        end

      end
    end
  end
end