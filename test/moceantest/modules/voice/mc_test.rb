require_relative '../../mocean_testing'
module Moceansdk
  module Modules
    module Voice

      class McTest < MoceanTest::Test
        def test_mc_say
          say = Mc.say

          assert_raises Moceansdk::Exceptions::RequiredFieldException do
            say.get_request_data
          end

          say.text = 'testing text'
          assert_equal 'testing text', say.get_request_data[:text]

          assert_equal 'testing text2', Mc.say('testing text2').get_request_data[:text]
        end

        def test_mc_dial
          dial = Mc.dial

          assert_raises Moceansdk::Exceptions::RequiredFieldException do
            dial.get_request_data
          end

          dial.to = 'testing to'
          assert_equal 'testing to', dial.get_request_data[:to]

          assert_equal 'testing to2', Mc.dial('testing to2').get_request_data[:to]
        end

        def test_mc_collect
          collect = Mc.collect

          assert_raises Moceansdk::Exceptions::RequiredFieldException do
            collect.get_request_data
          end

          collect.event_url = 'testing event url'
          collect.minimum = 1
          collect.maximum = 10
          collect.timeout = 500
          assert_equal 'testing event url', collect.get_request_data[:'event-url']

          collect = Mc.collect('testing event url2')
          collect.minimum = 1
          collect.maximum = 10
          collect.timeout = 500
          assert_equal 'testing event url2',collect.get_request_data[:'event-url']
        end

        def test_mc_play
          play = Mc.play

          assert_raises Moceansdk::Exceptions::RequiredFieldException do
            play.get_request_data
          end

          play.files = 'testing file'
          assert_equal 'testing file', play.get_request_data[:file]

          assert_equal 'testing file2', Mc.play('testing file2').get_request_data[:file]
        end

        def test_mc_sleep
          sleep = Mc.sleep

          assert_raises Moceansdk::Exceptions::RequiredFieldException do
            sleep.get_request_data
          end

          sleep.duration = 10000
          assert_equal 10000, sleep.get_request_data[:duration]

          assert_equal 20000, Mc.sleep(20000).get_request_data[:duration]
        end

        def test_mc_record
          assert_equal 'record', Mc.record.get_request_data[:action]
        end
      end

    end
  end
end