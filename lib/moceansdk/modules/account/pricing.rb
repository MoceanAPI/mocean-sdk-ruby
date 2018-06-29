require_relative "../abstract"

class Pricing < MoceanFactory
    
    def initialize client
        super(client)
        required_fields = ['mocean-api-key','mocean-api-secret']
    end
    
    def setMcc param
        @params['mocean-mcc'] = param
        return self
    end
    
    def setMnc param
        @params['mocean-mnc'] = param
        return self
    end
    
    def setDelimiter param
        @params['mocean-delimiter'] = param
        return self
    end
    
    def setRespFormat param
        @params['mocean-resp-format'] = param
        return self
    end
    
    def inquiry params = {}
        create(params)
        createFinalParams
        isRequiredFieldsSet
        response = Transmitter.new('/rest/1/account/pricing','get',@params)
        reset
        return response.getResponse()
    end
end