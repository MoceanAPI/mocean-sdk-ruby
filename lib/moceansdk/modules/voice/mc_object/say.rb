module Moceansdk
  module Modules
    module Voice
      module McObject

        class Say < AbstractMc
          def initialize(params = nil)
            super(params)

            if @params[:language].nil?
              @params[:language] = 'en-US'
            end
          end

          def language=(param)
            @params[:language] = param
          end

          def text=(param)
            @params[:text] = param
          end

          def barge_in=(param)
            @params[:'barge-in'] = param
          end

          def clear_digit_cache=(param)
            @params[:'clear-digit-cache'] = param
          end

          def required_key
            ['text', 'language']
          end

          def action
            'say'
          end
        end

      end
    end
  end
end