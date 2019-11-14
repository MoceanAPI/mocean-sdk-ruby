require_relative '../../../mocean_testing'
module Moceansdk
  module Modules
    module Voice
      module McObject

        class SleepTest < MoceanTest::Test
          def test_params
            params = {
                'duration': 10000,
                'action': 'sleep'
            }
            assert_equal params, Sleep.new(params).get_request_data

            sleep = Sleep.new
            sleep.duration = 10000

            assert_equal params, sleep.get_request_data
          end

          def test_if_action_auto_defined
            params = {
                'duration': 10000
            }
            assert_equal 'sleep', Sleep.new(params).get_request_data[:action]
          end

          def test_if_required_field_not_set
            assert_raises Moceansdk::Exceptions::RequiredFieldException do
              Sleep.new.get_request_data
            end
          end
        end

      end
    end
  end
end