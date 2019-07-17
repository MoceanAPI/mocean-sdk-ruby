module Moceansdk
  module Modules
    module Voice
      module McccObject

        class Collect < AbstractMccc
          def initialize(params = nil)
            super(params)

            if @params[:min].nil?
              @params[:min] = 1
            end

            if @params[:max].nil?
              @params[:max] = 10
            end

            if @params[:terminators].nil?
              @params[:terminators] = '#'
            end

            if @params[:timeout].nil?
              @params[:timeout] = 5000
            end
          end

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
            ['event-url', 'min', 'max', 'terminators', 'timeout']
          end

          def action
            'collect'
          end
        end

      end
    end
  end
end