require "net/http"
require "uri"

class MoceanFactory
    attr_accessor :params

    def initialize client
        @params = {}
        @params['mocean-api-key'] = client.api_key
        @params['mocean-api-secret'] = client.api_secret
    end
    
    def create params = {}
        if params.class != Hash
            raise Exception.new('Params past into create must be hash.')
        end
        tmp_params = params.clone
        tmp_params.each do |key,value|
            if !isParamPrefixSet(key)
                new_key ="mocean-"+key
                params[new_key] = value
                params.delete(key)
            end
        end
        tmp_params = nil
        @params = @params.merge(params)
    end
    
    def createFinalParams
        final_params = {}
        @params.each do |key,value|
            unless value.nil? || (value.class != Integer && value.empty?)
                final_params[key] = value
                
            end
        end
        @params =  final_params
    end
    
    def createResponse response
    end
    
    def isParamPrefixSet param
        if param.class != String
            raise Exception.new("Parameter key must be string, "+param.class+" given.")
        end
        if param.scan(/^mocean-/i).empty?
            return false
        end
        return true
    end
    
    def isRequiredFieldsSet
        if @required_fields.class == 'Array' && !@required_fields.empty?
            @required_fields.each do |field|
                if @params[field] == nil
                    raise Exception.new("#{field} is mandatory field, can't leave empty")
                end
            end
        end
        return true
    end
    
    def reset()
       @params.each do |key,value|
           if key == 'mocean-api-key' || key == 'mocean-api-secret'
               next
           end
           @params[key] = nil
       end       
    end
    
end

class Transmitter
   
    def initialize uri,method,params
        @URL = 'rest.moceanapi.com'
        @uri = uri 
        @params = params
        @params['mocean-medium'] = 'RUBY-SDK'
        
        begin
            @http = Net::HTTP.new(@URL,443)  
            @http.use_ssl = true
        rescue Exception
            raise Exception.new('Unable to create connection, please contact SDK provider.')
        end
        
        case method.downcase
            when 'get'
                @response = __get
            when 'post'
                @response = __post
            when 'put'
                @response = __put
            when 'delete'
                @response = __delete
            else
                raise Exception.new("Unknown request method, please contact SDK provider.")
        end
         
    end
  
    def __get
        form_data = ''
        if @params.size > 0
            form_data = URI.encode_www_form(@params)
        end
        request = Net::HTTP::Get.new(@uri+"?"+form_data)
        return @http.request(request)
    end
  
    def __post
        request = Net::HTTP::Post.new(@uri)
        if @params.size > 0
            request.form_data = @params
        end
        return @http.request(request)
    end
  
    def __put
        request = Net::HTTP::Put.new(@uri)
        if @params.size > 0
            request.form_data = @params
        end
        return @http.request(request)
    end
  
    def  __delete
        request = Net::HTTP::Delete.new(@uri)
        if @params.size > 0
            request.form_data = @params
        end
        return @http.request(request)
    end
  
    def getResponse
        @response.body || nil
    end
  
end