require_relative '../../../mocean_testing'
module Moceansdk
  module Modules
    module Voice
      module McObject

        class DialTest < MoceanTest::Test
          def test_params
            params = {
                'to': 'testing to',
                'action': 'dial',
                'from': 'callerid',
                'dial-sequentially': true,
            }
            assert_equal params, Dial.new(params).get_request_data

            dial = Dial.new
            dial.to = 'testing to'
            dial.from = 'callerid'
            dial.dial_sequentially = true

            assert_equal params, dial.get_request_data
          end

          def test_if_action_auto_defined
            params = {
                'to': 'testing to'
            }
            assert_equal 'dial', Dial.new(params).get_request_data[:action]
          end

          def test_if_required_field_not_set
            assert_raises Moceansdk::Exceptions::RequiredFieldException do
              Dial.new.get_request_data
            end
          end
        end

      end
    end
  end
end