require_relative '../../../mocean_testing'
module Moceansdk
  module Modules
    module Voice
      module McccObject

        class AbstractMcccTest < MoceanTest::Test
          def test_throw_exception_if_calling_method_directly
            assert_raises NotImplementedError do
              AbstractMccc.new.required_key
            end

            assert_raises NotImplementedError do
              AbstractMccc.new.action
            end
          end
        end

      end
    end
  end
end