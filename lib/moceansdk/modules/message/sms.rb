require_relative "../abstract"

class Sms < MoceanFactory
    
    attr_writer :flashSms 
    
    def initialize client
        super(client)
        @flashSms = false
        @required_fileds = ['mocean-api-key','mocean-api-secret','mocean-from','mocean-to','mocean-text']
    end
    
    def setFrom param
        @params['mocean-from'] = param
        return self
    end
    
    def setTo param
        @params['mocean-to'] = param
        return self
    end
    
    def setText param
        @params['mocean-text'] = param
        return self
    end
    
    def setUdh param
        @params['mocean-udh'] = param
        return self
    end
    
    def setCoding param
        @params['mocean-coding'] = param
        return self
    end
    
    def setDlrMask param
        @params['mocean-dlr-mask'] = param
        return self
    end
    
    def setDlrUrl param
        @params['mocean-dlr-url'] = param
        return self
    end
    
    def setSchedule param
        @params['mocean-schedule'] = param
        return self
    end
    
    def setMclass param
        @params['mocean-mclass'] = param
        return self
    end
    
    def setAltDcs param
        @params['mocean-alt-dcs'] = param
        return self
    end
    
    def setCharset param
        @params['mocean-charset'] = param
        return self
    end
    
    def setValidity param
        @params['mocean-validity'] = param
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
        if @flashSms == true
            setMclass(1)
            setAltDcs(1)
        end
        createFinalParams
        isRequiredFieldsSet
        response = Transmitter.new('/rest/1/sms','post',@params)
        return response.getResponse()
    end
    
    
end
