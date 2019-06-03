module Moceansdk
  module Exceptions

    class MoceanError < StandardError
      attr_reader :error_response

      def initialize(msg, error_response = nil)
        if error_response.nil?
          super(msg)
        else
          super(error_response['err_msg'])
          @error_response = error_response
        end
      end
    end

  end
end
