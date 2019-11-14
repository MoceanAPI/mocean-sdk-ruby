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

WebMock.disable_net_connect!

module MoceanTest
  class Test < Minitest::Test
    def verify_params_with(body, expected_body)
      expected_body.each do |key, value|
        assert_equal ["#{value}"], body["#{key}"]
      end
    end

    def file_response(file_name, status_code = 200)
      {body: File.new(File.dirname(__FILE__) + '/resources/' + file_name), status: status_code}
    end
  end

  class TestingUtils
    def self.client_obj(transmitter = nil)
      Moceansdk::Client.new(Moceansdk::Auth::Basic.new('test api key', 'test api secret'), transmitter)
    end

    def self.resource_file_path(file_name)
      File.dirname(__FILE__) + '/resources/' + file_name
    end

    def self.mock_http_request(uri, version = '2')
      WebMock.stub_request(:any, "#{Moceansdk::Modules::Transmitter.new.default_options[:base_url]}/rest/#{version}#{uri}")
          .with(query: WebMock.hash_including({}))
          .to_return do |request|
        body = if request.method == :get
                 CGI.parse(request.uri.query)
               else
                 CGI.parse(request.body)
               end

        request.body = body
        yield request
      end
    end
  end

end