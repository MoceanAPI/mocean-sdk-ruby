require_relative "../abstract"

class Verify_validate < MoceanFactory
    
    def __init__ client
        super(client)
        @required_fields = ['mocean-api-key','mocean-api-secret','mocean-reqid','mocean-otp-code']
    end
    
    def setReqid param
        @params['mocean-reqid'] = param
        return self
    end
    
    def setCode param
        @params['mocean-code'] = param
        return self
    end
    
    def setRespFormat param
        @params['mocean-resp-format'] = param
        return self
    end
    
    def create params = {}
        reset
        super(param)
        return self
    end
    
    def send 
        createFinalParams
        isRequiredFieldsSet
        response = Transmitter.new('/rest/1/verify/check','post',@params)
        return response.getResponse()
    end
    
end