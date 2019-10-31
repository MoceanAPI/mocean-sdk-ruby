module Moceansdk
  module Modules
    module Voice
      module McccObject

        class Collect < AbstractMccc
          def event_url=(param)
            @params[:'event-url'] = param
          end

          def minimum=(param)
            @params[:min] = param
          end

          def maximum=(param)
            @params[:max] = param
          end

          def terminators=(param)
            @params[:terminators] = param
          end

          def timeout=(param)
            @params[:timeout] = param
          end

          def required_key
            ['event-url', 'min', 'max', 'timeout']
          end

          def action
            'collect'
          end
        end

      end
    end
  end
end