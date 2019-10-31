module Moceansdk
  module Modules
    module Voice
      module McccObject

        class Sleep < AbstractMccc
          def duration=(param)
            @params[:duration] = param
          end

          def required_key
            ['duration']
          end

          def action
            'sleep'
          end
        end

      end
    end
  end
end