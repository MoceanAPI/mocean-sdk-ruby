module Moceansdk
  module Auth

    class Basic < AbstractAuth
      def initialize(api_key = nil, api_secret = nil)
        @params = {}
        @params['mocean-api-key'] = api_key unless api_key.nil?
        @params['mocean-api-secret'] = api_secret unless api_secret.nil?
      end

      def api_key=(api_key)
        @params['mocean-api-key'] = api_key
      end

      def api_secret=(api_secret)
        @params['mocean-api-secret'] = api_secret
      end

      def auth_method
        'basic'
      end

      def params
        @params
      end
    end

  end
end
