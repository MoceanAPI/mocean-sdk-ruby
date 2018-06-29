class Client
    attr_reader :api_key,:api_secret
    def initialize api_key = '',api_secret = ''
        @api_key =  api_key 
        @api_secret =  api_secret
    end

    def set_api_key(api_key)
        @api_key = api_key
    end
    def set_api_secret(api_secret)
        @api_secret = api_secret
    end
end