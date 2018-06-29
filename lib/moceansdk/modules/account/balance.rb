require_relative "../abstract"

class Balance < MoceanFactory
    def initialize client
        super(client)
        @required_fields = ['mocean-api-key','mocean-api-secret']
    end
    
    def setRespFormat param
        @params['mocean-resp-format'] = param
        return self
    end
    
    def inquiry params = {}
        create(params)
        createFinalParams
        isRequiredFieldsSet
        response = Transmitter.new('/rest/1/account/balance','get', @params)
        reset
        return response.getResponse()
    end
end