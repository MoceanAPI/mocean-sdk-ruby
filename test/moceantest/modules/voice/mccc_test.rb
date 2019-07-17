require_relative '../../mocean_testing'
module Moceansdk
  module Modules
    module Voice

      class McccTest < MoceanTest::Test
        def test_mccc_say
          say = Mccc.say

          assert_raises Moceansdk::Exceptions::RequiredFieldException do
            say.get_request_data
          end

          say.text = 'testing text'
          assert_equal 'testing text', say.get_request_data[:text]

          assert_equal 'testing text2', Mccc.say('testing text2').get_request_data[:text]
        end

        def test_mccc_bridge
          bridge = Mccc.bridge

          assert_raises Moceansdk::Exceptions::RequiredFieldException do
            bridge.get_request_data
          end

          bridge.to = 'testing to'
          assert_equal 'testing to', bridge.get_request_data[:to]

          assert_equal 'testing to2', Mccc.bridge('testing to2').get_request_data[:to]
        end

        def test_mccc_collect
          collect = Mccc.collect

          assert_raises Moceansdk::Exceptions::RequiredFieldException do
            collect.get_request_data
          end

          collect.event_url = 'testing event url'
          assert_equal 'testing event url', collect.get_request_data[:'event-url']

          assert_equal 'testing event url2', Mccc.collect('testing event url2').get_request_data[:'event-url']
        end

        def test_mccc_play
          play = Mccc.play

          assert_raises Moceansdk::Exceptions::RequiredFieldException do
            play.get_request_data
          end

          play.files = 'testing file'
          assert_equal 'testing file', play.get_request_data[:file]

          assert_equal 'testing file2', Mccc.play('testing file2').get_request_data[:file]
        end

        def test_mccc_sleep
          sleep = Mccc.sleep

          assert_raises Moceansdk::Exceptions::RequiredFieldException do
            sleep.get_request_data
          end

          sleep.duration = 10000
          assert_equal 10000, sleep.get_request_data[:duration]

          assert_equal 20000, Mccc.sleep(20000).get_request_data[:duration]
        end
      end

    end
  end
end