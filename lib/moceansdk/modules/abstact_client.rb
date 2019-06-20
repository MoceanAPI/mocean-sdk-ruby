module Moceansdk
  module Modules

    class AbstractClient
      attr_accessor :params

      def initialize(obj_auth, transmitter)
        @params = obj_auth.params
        @transmitter = transmitter
      end

      def create(params = {})
        @params = @params.merge(params) if params.is_a? Hash
      end

      def create_final_params
        final_params = {}
        @params.each do |key, value|
          unless value.nil?
            param_prefix_set?(key) ? final_params[key] = value : final_params["mocean-#{key}"] = value
          end
        end

        # convert string hash to symbol hash
        @params = final_params.inject({}) {|memo, (k, v)| memo[k.to_sym] = v; memo}
      end

      def param_prefix_set?(key)
        cloned_key = if key.is_a? String
                       key
                     else
                       key.to_s
                     end

        return false if cloned_key.scan(/^mocean-/i).empty?

        true
      end

      def required_field_set?
        if @required_fields.is_a?(Array) && !@required_fields.empty?
          @required_fields.each do |field|
            if @params[:"#{field}"].nil?
              raise Moceansdk::Exceptions::RequiredFieldException, "#{field} is mandatory field, can't leave empty"
            end
          end
        end

        true
      end
    end

  end
end