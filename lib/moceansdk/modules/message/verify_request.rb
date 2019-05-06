require_relative "../abstract"

class Verify_request < MoceanFactory
    
    def __init__ client
        super(client)
        @required_fields = ['mocean-api-key','mocean-api-secret','mocean-to','mocean-brand']
        @charge_type = ChargeType.CHARGE_PER_CONVERSION
    end
    
    def setTo param
        @params['mocean-to'] = param
        return self
    end
    
    def setBrand
        @params['mocean-brand'] = param
        return self;
    end
    
    def setFrom param
        @params['mocean-from'] = param
        return self;
    end
    
    def setTemplate param
        @params['mocean-template'] = param
        return self;
    end
    
    def setPinValidate param
        @params['mocean-pin-validate'] = param
        return self
    end
    
    def setNextEventWait param
        @params['mocean-next-event-wait'] = param
        return self
    end
    
    def setRespFormat param
        @params['mocean-resp-format'] = param
        return self
    end
    
    def create params = {}
        reset
        super(params)
        return self
    end

    def sendAs chargeType
        @charge_type = chargeType
        return self
    end

    def send
        createFinalParams
        isRequiredFieldsSet
        @verify_request_url = '/rest/1/verify/req'
        if @charge_type === ChargeType.CHARGE_PER_ATTEMPT
            @verify_request_url += '/sms'
        end
        response = Transmitter.new(@verify_request_url,'post',@params)
        return response.getResponse()
    end
    
    
end