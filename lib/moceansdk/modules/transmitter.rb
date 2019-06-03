module Moceansdk
  module Modules

    class Transmitter
      def initialize(options = nil)
        @options = default_options

        unless options.nil?
          @options = @options.merge(options)
        end
      end

      def default_options
        {
            base_url: 'https://rest.moceanapi.com',
            version: '1'
        }
      end

      def get(uri, params)
        request('get', uri, params)
      end

      def post(uri, params)
        request('post', uri, params)
      end

      def request(method, uri, params)
        params[:'mocean-medium'] = 'RUBY-SDK'

        # use json if default not set
        params[:'mocean-resp-format'] = 'json' unless params[:'mocean-resp-format']

        url = @options[:base_url] + '/rest/' + @options[:version] + uri

        res = if method.casecmp('get').zero?
                HTTP.get(url, params: params)
              else
                HTTP.post(url, form: params)
              end

        format_response(res.to_s, params[:'mocean-resp-format'] == 'xml', uri)
      end

      def format_response(response_text, is_xml = false, uri = nil)
        raw_response = response_text

        # format for v1
        if !uri.nil? && @options[:version] == '1' && is_xml
          if uri == '/account/pricing'
            response_text = response_text
                                .sub('<data>', '<destinations>')
                                .sub('</data>', '</destinations>')
          elsif uri == '/sms'
            response_text = response_text
                                .sub('<result>', '<result><messages>')
                                .sub('</result>', '</messages></result>')
          end
        end

        processed_response = ResponseFactory.create_object(
            response_text
                .sub('<verify_request>', '')
                .sub('</verify_request>', '')
                .sub('<verify_check>', '')
                .sub('</verify_check>', '')
        )

        if processed_response['status'] && processed_response['status'] != '0' && processed_response['status'] != 0
          raise Moceansdk::Exceptions::MoceanError, processed_response['err_msg']
        end

        # format for v1
        if !uri.nil? && is_xml
          if uri == '/account/pricing'
            processed_response.destinations = processed_response.destinations.destination
          elsif uri == '/sms'
            unless processed_response.messages.message.is_a? Array
              processed_response.messages.message = [processed_response.messages.message]
            end
            processed_response.messages = processed_response.messages.message
          end
        end

        processed_response.raw_response = raw_response
        processed_response
      end
    end

  end
end