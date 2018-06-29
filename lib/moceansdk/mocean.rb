class Mocean
    
    attr_reader :obj_auth
      
    def initialize client = Client
        if client.class == Client
            @obj_auth = client
        elsif client.api_key == nil || client.api_secret == nil
            raise Exception.new("Api key and api secret can't be empty")
        else
            raise Exception.new("Arguement pass into Mocean object must be Client object")
        end        
    end

    def sms
        require_relative "modules/message/sms"
        return Sms.new(@obj_auth) 
        
    end
    
    def flashSms
        require_relative "modules/message/sms"
        _sms = Sms.new(@obj_auth)
        _sms.flashSms = true
        return _sms
    end

    def pricing_list
        require_relative "modules/account/pricing"
        return Pricing.new(@obj_auth)
    end

    def balance
        require_relative "modules/account/balance"
        return Balance.new(@obj_auth)
    end

    def message_status
        require_relative "modules/message/message_status"
        return Message_status.new(@obj_auth)
    end
    
    def verify_request
        require_relative "modules/message/verify_request"
        return Verify_request.new(@obj_auth)
    end

    def verify_validate
        require_relative "modules/message/verify_validate"
        return Verify_validate.new(@obj_auth)
    end
end