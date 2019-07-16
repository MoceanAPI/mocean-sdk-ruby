module Moceansdk
  module Modules
    module Voice
      module McccObject

        class Play < AbstractMccc
          def initialize(params = nil)
            super(params)
          end

          def files=(param)
            @params['file'] = param
          end

          def barge_in=(param)
            @params['barge-in'] = param
          end

          def required_key
            ['file']
          end

          def action
            'play'
          end
        end

      end
    end
  end
end