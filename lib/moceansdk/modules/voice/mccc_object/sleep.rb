module Moceansdk
  module Modules
    module Voice
      module McccObject

        class Sleep < AbstractMccc
          def initialize(params = nil)
            super(params)
          end

          def duration=(param)
            @params['duration'] = param
          end

          def barge_in=(param)
            @params['barge-in'] = param
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