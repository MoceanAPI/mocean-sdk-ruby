require_relative "../abstract"

class Verify_request < MoceanFactory
    
    def __init__ client
        super(client)
        @required_fields = ['mocean-api-key','mocean-api-secret','mocean-to','mocean-brand']
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
    
    def send 
        createFinalParams
        isRequiredFieldsSet
        response = Transmitter.new('/rest/1/verify/req','post',@params)
        return response.getResponse()
    end
    
    
end