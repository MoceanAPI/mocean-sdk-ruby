require_relative '../../mocean_testing'
module Moceansdk
  module Modules
    module Voice

      class McBuilderTest < MoceanTest::Test
        def test_add
          play = Mc.play 'testing file'

          builder = McBuilder.new
          builder.add play
          assert_equal builder.build.count, 1
          assert_equal play.get_request_data, builder.build[0]

          play.files = 'testing file2'
          builder.add play
          assert_equal builder.build.count, 2
          assert_equal play.get_request_data, builder.build[1]
        end

        def test_throw_exception_for_add_method_pass_in_non_mc_object
          assert_raises Moceansdk::Exceptions::MoceanError do
            McBuilder.new.add('abc')
          end
        end
      end

    end
  end
end