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

        def test_json_inquiry
          MoceanTest::TestingUtils.intercept_http_request(
              'balance.json',
              '/account/balance'
          ) do |method, uri|
            assert_equal method, :get
            assert_equal uri.path, MoceanTest::TestingUtils.test_uri('/account/balance')
          end

          client = MoceanTest::TestingUtils.client_obj
          res = client.balance.inquiry

          assert_equal res.to_s, MoceanTest::TestingUtils.response_str('balance.json')
          object_test(res)
        end

        def test_xml_inquiry
          MoceanTest::TestingUtils.intercept_http_request(
              'balance.xml',
              '/account/balance'
          ) do |method, uri|
            assert_equal method, :get
            assert_equal uri.path, MoceanTest::TestingUtils.test_uri('/account/balance')
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