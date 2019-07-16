require_relative '../../../mocean_testing'
module Moceansdk
  module Modules
    module Voice
      module McccObject

        class CollectTest < MoceanTest::Test
          def test_params
            params = {
                'event-url' => 'testing event url',
                'min' => 1,
                'max' => 10,
                'terminators' => '#',
                'timeout' => 10000,
                'action' => 'collect'
            }
            assert_equal params, Collect.new(params).get_request_data

            collect = Collect.new
            collect.event_url = 'testing event url'
            collect.minimum = 1
            collect.maximum = 10
            collect.terminators = '#'
            collect.timeout = 10000

            assert_equal params, collect.get_request_data
          end

          def test_if_action_auto_defined
            params = {
                'event-url' => 'testing event url',
                'min' => 1,
                'max' => 10,
                'terminators' => '#',
                'timeout' => 10000
            }
            assert_equal 'collect', Collect.new(params).get_request_data['action']
          end

          def test_if_required_field_not_set
            assert_raises Moceansdk::Exceptions::RequiredFieldException do
              Collect.new.get_request_data
            end
          end
        end

      end
    end
  end
end