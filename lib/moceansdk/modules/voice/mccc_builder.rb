module Moceansdk
  module Modules
    module Voice

      class McccBuilder
        def initialize
          @mccc = []
        end

        def add(mccc)
          unless mccc.is_a? McccObject::AbstractMccc
            raise Moceansdk::Exceptions::MoceanError, 'mccc_object must extend AbstractMccc'
          end

          @mccc.push(mccc)
          self
        end

        def build
          converted = []
          @mccc.each do |mccc|
            converted.push(mccc.get_request_data)
          end
          converted
        end
      end

    end
  end
end
