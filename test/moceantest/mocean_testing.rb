if ENV['CI'] == 'true'
  require 'simplecov'
  require 'codecov'

  SimpleCov.start do
    add_filter 'test/moceantest'
  end
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

require 'moceansdk'
require 'minitest/autorun'
require 'webmock/minitest'
require 'cgi'

module MoceanTest
  class Test < Minitest::Test
  end

  class TestingUtils
    def self.client_obj(transmitter = nil)
      Moceansdk::Client.new(Moceansdk::Auth::Basic.new('test api key', 'test api secret'), transmitter)
    end

    def self.resource_file_path(file_name)
      File.dirname(__FILE__) + '/resources/' + file_name
    end

    def self.response_str(file_name)
      File.read(resource_file_path(file_name))
    end

    def self.intercept_http_request(file_name, uri, version = '2')
      WebMock.stub_request(:any, "#{Moceansdk::Modules::Transmitter.new.default_options[:base_url]}/rest/#{version}#{uri}")
          .with(query: WebMock.hash_including({}))
          .to_return(body: File.new(resource_file_path(file_name)), status: 200)

      WebMock.after_request do |request_signature|
        uri = URI.parse(request_signature.uri)

        body = if request_signature.method == 'get'
                 CGI.parse(uri.query)
               else
                 CGI.parse(request_signature.body)
               end

        yield(request_signature.method, uri, body) if block_given?

        # clear callbacks for new defined
        WebMock.reset_callbacks
        WebMock.reset!
      end
    end

    def self.test_uri(uri, version = '2')
      "/rest/#{version}#{uri}"
    end
  end

end