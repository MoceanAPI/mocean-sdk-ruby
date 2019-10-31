require_relative '../../../mocean_testing'
module Moceansdk
  module Modules
    module Voice
      module McccObject

        class RecordTest < MoceanTest::Test
          def test_if_action_auto_defined
            assert_equal 'record', Record.new.get_request_data[:action]
          end
        end

      end
    end
  end
end