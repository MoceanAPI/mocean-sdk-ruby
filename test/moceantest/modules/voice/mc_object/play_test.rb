require_relative '../../../mocean_testing'
module Moceansdk
  module Modules
    module Voice
      module McObject

        class PlayTest < MoceanTest::Test
          def test_params
            params = {
                'file': 'testing file',
                'barge-in': true,
                'clear-digit-cache': true,
                'action': 'play'
            }
            assert_equal params, Play.new(params).get_request_data

            play = Play.new
            play.files = 'testing file'
            play.barge_in = true
            play.clear_digit_cache = true

            assert_equal params, play.get_request_data
          end

          def test_if_action_auto_defined
            params = {
                'file': 'testing file',
                'barge-in': true
            }
            assert_equal 'play', Play.new(params).get_request_data[:action]
          end

          def test_if_required_field_not_set
            assert_raises Moceansdk::Exceptions::RequiredFieldException do
              Play.new.get_request_data
            end
          end
        end

      end
    end
  end
end