require_relative '../../mocean_testing'
module Moceansdk
  module Modules
    module Command

      class McBuilderTest < MoceanTest::Test
        def test_command_add
          send_text = Mc.tg_send_text.from("moceantestbot").to("123456789").content("hello world")

          builder = McBuilder.new
          builder.add send_text
          assert_equal builder.build.count, 1
          assert_equal send_text.get_request_data, builder.build[0]

          send_text.from 'another test bot'
          send_text.to '987654321'
          builder.add send_text
          assert_equal builder.build.count, 2
          assert_equal send_text.get_request_data, builder.build[1]
        end

        def test_command_throw_exception_for_add_method_pass_in_non_mc_object
          assert_raises Moceansdk::Exceptions::MoceanError do
            McBuilder.new.add('abc')
          end
        end
      end

    end
  end
end