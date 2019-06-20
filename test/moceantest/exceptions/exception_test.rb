require_relative '../mocean_testing'
module Moceansdk
  module Exceptions

    class ExceptionTest < MoceanTest::Test
      def test_raise_with_error_response
        file_content = File.read(MoceanTest::TestingUtils.resource_file_path('error_response.json'))

        begin
          Moceansdk::Modules::Transmitter.new.format_response(file_content)
          assert false
        rescue MoceanError => ex
          assert_equal ex.error_response.to_s, file_content
          assert ex.error_response.is_a? Hash
          assert_equal ex.error_response.status, '1'
        end
      end
    end

  end
end