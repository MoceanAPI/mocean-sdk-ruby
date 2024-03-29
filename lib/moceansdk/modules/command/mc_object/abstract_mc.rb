module Moceansdk
  module Modules
    module Command
      module McObject

        class AbstractMc
          def initialize(params = nil)
            @params = {}
            @params = Moceansdk::Utils.convert_to_symbol_hash(params) unless params.nil?
          end

          def get_request_data
            @params = Moceansdk::Utils.convert_to_symbol_hash(@params)
            required_key.each do |key|
              if @params[:"#{key}"].nil?
                raise Moceansdk::Exceptions::RequiredFieldException, "#{key} is mandatory field, can't leave empty (#{self})"
              end
            end
            @params[:action] = action
            @params
          end

          def required_key
            raise NotImplementedError, 'AbstractMc is a abstract class'
          end

          def action
            raise NotImplementedError, 'AbstractMc is a abstract class'
          end

        end

      end
    end
  end
end
