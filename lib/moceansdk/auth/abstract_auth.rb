module Moceansdk
  module Auth

    class AbstractAuth
      def auth_method
        raise NotImplementedError, 'AbstractAuth is a abstract class'
      end

      def params
        raise NotImplementedError, 'AbstractAuth is a abstract class'
      end
    end

  end
end
