require_relative '../../../mocean_testing'
module Moceansdk
  module Modules
    module Voice
      module McccObject

        class SayTest < MoceanTest::Test
          def test_params
            params = {
                'language' => 'testing language',
                'text' => 'testing text',
                'barge-in' => true,
                'action' => 'say'
            }
            assert_equal params, Say.new(params).get_request_data

            say = Say.new
            say.language = 'testing language'
            say.text = 'testing text'
            say.barge_in = true

            assert_equal params, say.get_request_data
          end

          def test_if_action_auto_defined
            params = {
                'language' => 'testing language',
                'text' => 'testing text',
                'barge-in' => true
            }
            assert_equal 'say', Say.new(params).get_request_data['action']
          end

          def test_if_required_field_not_set
            assert_raises Moceansdk::Exceptions::RequiredFieldException do
              Say.new.get_request_data
            end
          end
        end

      end
    end
  end
end