require_relative '../../../mocean_testing'
module Moceansdk
  module Modules
    module Voice
      module McccObject

        class BridgeTest < MoceanTest::Test
          def test_params
            params = {
                'to': 'testing to',
                'action': 'dial'
            }
            assert_equal params, Bridge.new(params).get_request_data

            bridge = Bridge.new
            bridge.to = 'testing to'

            assert_equal params, bridge.get_request_data
          end

          def test_if_action_auto_defined
            params = {
                'to': 'testing to'
            }
            assert_equal 'dial', Bridge.new(params).get_request_data[:action]
          end

          def test_if_required_field_not_set
            assert_raises Moceansdk::Exceptions::RequiredFieldException do
              Bridge.new.get_request_data
            end
          end
        end

      end
    end
  end
end