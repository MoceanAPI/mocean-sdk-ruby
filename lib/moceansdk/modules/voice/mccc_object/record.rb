module Moceansdk
  module Modules
    module Voice
      module McccObject

        class Record < AbstractMccc
          def required_key
            []
          end

          def action
            'record'
          end
        end

      end
    end
  end
end