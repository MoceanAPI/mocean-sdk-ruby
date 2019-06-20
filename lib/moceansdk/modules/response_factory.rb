module Moceansdk
  module Modules

    class ResponseFactory
      def self.create_object(raw_response)
        begin
          res = JSON.load(raw_response, proc {|obj|
            case obj
            when Hash
              obj.each {|k, v|
                obj[k] = if v.is_a? Float
                           # hardcoded float to 4 decimal string
                           sprintf('%.4f', v)
                         elsif v.is_a? Integer
                           v.to_s
                         else
                           v
                         end
              }
            when Array
              obj.map! {|v| v}
            end
          })
        rescue JSON::JSONError
          begin
            res = XmlSimple.xml_in(raw_response, 'ForceArray': false)
          rescue StandardError
            raise Moceansdk::Exceptions::MoceanError, 'unable to parse response, ' + raw_response
          end
        end

        hashed_res = HashExtended.new.merge(res)
        hashed_res.to_dot
      end
    end

    class HashExtended < Hash
      attr_accessor :raw_response

      def to_s
        @raw_response
      end

      def to_hash
        inspect
      end
    end

  end
end