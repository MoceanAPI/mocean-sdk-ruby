require_relative '../../mocean_testing'
module Moceansdk
  module Modules
    module Account

      class BalanceTest < MoceanTest::Test
        def test_setter
          balance = MoceanTest::TestingUtils.client_obj.balance
          balance.resp_format = 'json'
          refute balance.params['mocean-resp-format'].nil?
          assert_equal 'json', balance.params['mocean-resp-format']
        end

        def test_inquiry
          fake = Minitest::Mock.new
          fake.expect :call, 'testing only', [String, String, Hash]

          transmitter_mock = Moceansdk::Modules::Transmitter.new
          transmitter_mock.stub(:request_and_parse_body, lambda {|method, uri, params|
            assert_equal method, 'get'
            assert_equal uri, '/account/balance'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)
            assert_equal client.balance.inquiry, 'testing only'
          end

          assert fake.verify
        end

        def test_json_response
          file_content = File.read(MoceanTest::TestingUtils.resource_file_path('balance.json'))
          fake = Minitest::Mock.new
          transmitter_mock = Moceansdk::Modules::Transmitter.new

          fake.expect :call, transmitter_mock.format_response(file_content), [String, String, Hash]
          transmitter_mock.stub(:request_and_parse_body, lambda {|method, uri, params|
            assert_equal method, 'get'
            assert_equal uri, '/account/balance'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)
            res = client.balance.inquiry

          assert_equal res.to_s, MoceanTest::TestingUtils.response_str('balance.json')
          object_test(res)
        end

        def test_xml_response
          file_content = File.read(MoceanTest::TestingUtils.resource_file_path('balance.xml'))
          fake = Minitest::Mock.new
          transmitter_mock = Moceansdk::Modules::Transmitter.new

          fake.expect :call, transmitter_mock.format_response(file_content, true, '/account/balance'), [String, String, Hash]
          transmitter_mock.stub(:request_and_parse_body, lambda {|method, uri, params|
            assert_equal method, 'get'
            assert_equal uri, '/account/balance'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)
            res = client.balance.inquiry

            assert_equal res.to_s, file_content
            object_test(res)
          end

          client = MoceanTest::TestingUtils.client_obj
          res = client.balance.inquiry

          assert_equal res.to_s, MoceanTest::TestingUtils.response_str('balance.xml')
          object_test(res)
        end

        private

        def object_test(balance_response)
          assert_equal balance_response.to_hash, balance_response.inspect
          assert_equal balance_response.status, '0'
          assert_equal balance_response.value, '100.0000'
        end
      end

    end
  end
end