require_relative '../mocean_testing'

module Moceansdk
  module Auth

    class AbstractAuthTest < MoceanTest::Test
      def test_throw_exception_if_calling_method_directly
        assert_raises NotImplementedError do
          AbstractAuth.new.params
        end

        assert_raises NotImplementedError do
          AbstractAuth.new.auth_method
        end
      end
    end

  end
end