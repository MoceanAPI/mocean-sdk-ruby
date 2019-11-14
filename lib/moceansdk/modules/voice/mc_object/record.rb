module Moceansdk
  module Modules
    module Voice
      module McObject

        class Record < AbstractMc
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