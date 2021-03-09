require_relative '../../mocean_testing'
module Moceansdk
  module Modules
    module Command

      class McTest < MoceanTest::Test
        def test_mc_send_tg_text
          tg_send_text_test = Mc.tg_send_text

          assert_raises Moceansdk::Exceptions::RequiredFieldException do
            tg_send_text_test.get_request_data
          end

          tg_send_text_test.from 'test bot'
          tg_send_text_test.to 'test chat'
          tg_send_text_test.content 'testing text'
          assert_equal 'testing text', tg_send_text_test.get_request_data[:content][:text]

          assert_equal 'testing text2', tg_send_text_test.content('testing text2').get_request_data[:content][:text]
        end
      end

    end
  end
end
