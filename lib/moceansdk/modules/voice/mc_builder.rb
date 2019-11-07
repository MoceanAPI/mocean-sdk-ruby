module Moceansdk
  module Modules
    module Voice

      class McBuilder
        def initialize
          @mc = []
        end

        def add(mc)
          unless mc.is_a? McObject::AbstractMc
            raise Moceansdk::Exceptions::MoceanError, 'mc_object must extend AbstractMc'
          end

          @mc.push(mc)
          self
        end

        def build
          converted = []
          @mc.each do |mc|
            converted.push(mc.get_request_data)
          end
          converted
        end
      end

    end
  end
end
