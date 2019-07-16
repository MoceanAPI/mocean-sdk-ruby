module Moceansdk
  module Modules
    module Voice
      module McccObject

        class Bridge < AbstractMccc
          def initialize(params = nil)
            super(params)
          end

          def to=(param)
            @params['to'] = param
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