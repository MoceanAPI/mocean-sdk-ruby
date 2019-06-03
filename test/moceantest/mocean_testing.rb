require 'moceansdk'
require 'minitest/autorun'

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
  end

end