module Moceansdk
  module Modules
    module Voice
      module McObject

        class Sleep < AbstractMc
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