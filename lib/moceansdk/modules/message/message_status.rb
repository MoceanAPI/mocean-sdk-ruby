require_relative "../abstract"

class Message_status < MoceanFactory
    def initialize client
        super(client)
        @required_fields = ['mocean-api-key','mocean-api-secret','mocean-msgid']
    end
    
    def setMsgid param
        @params['mocean-msgid'] = param
    end
    
    def setRespFormat param
        @params['mocean-resp-format'] = param
    end
    
    def inquiry params
        create(params)
        createFinalParams
        isRequiredFieldsSet
        response = Transmitter.new('/rest/1/report/message','get',@params)
        reset
        return response.getResponse()
    end
end