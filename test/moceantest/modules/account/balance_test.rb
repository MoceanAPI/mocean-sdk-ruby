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
          MoceanTest::TestingUtils.mock_http_request('/account/balance') do |request|
            assert_equal request.method, :get
            file_response('balance.json')
          end

          client = MoceanTest::TestingUtils.client_obj
          res = client.balance.inquiry
          object_test(res)
        end

        def test_xml_inquiry
          MoceanTest::TestingUtils.mock_http_request('/account/balance') do |request|
            assert_equal request.method, :get
            file_response('balance.xml')
          end

          client = MoceanTest::TestingUtils.client_obj
          res = client.balance.inquiry({'mocean-resp-format': 'xml'})
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