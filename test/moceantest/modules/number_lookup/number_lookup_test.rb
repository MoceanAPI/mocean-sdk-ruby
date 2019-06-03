require_relative '../../mocean_testing'
module Moceansdk
  module Modules
    module NumberLookup

      class NumberLookupTest < MoceanTest::Test
        def setup
          @client = MoceanTest::TestingUtils.client_obj
        end

        def test_setter
          number_lookup = @client.number_lookup

          number_lookup.to = 'test to'
          assert number_lookup.params['mocean-to'] != nil
          assert_equal 'test to', number_lookup.params['mocean-to']

          number_lookup.nl_url = 'test nl url'
          assert number_lookup.params['mocean-nl-url'] != nil
          assert_equal 'test nl url', number_lookup.params['mocean-nl-url']

          number_lookup.resp_format = 'json'
          assert number_lookup.params['mocean-resp-format'] != nil
          assert_equal 'json', number_lookup.params['mocean-resp-format']
        end

        def test_inquiry
          fake = Minitest::Mock.new
          fake.expect :call, 'testing only', [String, String, Hash]

          transmitter_mock = Moceansdk::Modules::Transmitter.new
          transmitter_mock.stub(:request, lambda {|method, uri, params|
            assert_equal method, 'get'
            assert_equal uri, '/nl'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)
            assert_equal client.number_lookup.inquiry('mocean-to' => 'test to'), 'testing only'
          end

          assert fake.verify
        end

        def test_json_response
          file_content = File.read(MoceanTest::TestingUtils.resource_file_path('number_lookup.json'))
          fake = Minitest::Mock.new
          fake.expect :call, Moceansdk::Modules::Transmitter.new.format_response(file_content), [String, String, Hash]

          transmitter_mock = Moceansdk::Modules::Transmitter.new
          transmitter_mock.stub(:request, lambda {|method, uri, params|
            assert_equal method, 'get'
            assert_equal uri, '/nl'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)
            res = client.number_lookup.inquiry('mocean-to' => 'test to')

            assert_equal res.to_s, file_content
            object_test(res)
          end

          assert fake.verify
        end

        def test_xml_response
          file_content = File.read(MoceanTest::TestingUtils.resource_file_path('number_lookup.xml'))
          fake = Minitest::Mock.new
          fake.expect :call, Moceansdk::Modules::Transmitter.new.format_response(file_content, true, '/nl'), [String, String, Hash]

          transmitter_mock = Moceansdk::Modules::Transmitter.new
          transmitter_mock.stub(:request, lambda {|method, uri, params|
            assert_equal method, 'get'
            assert_equal uri, '/nl'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)
            res = client.number_lookup.inquiry('mocean-to' => 'test to')

            assert_equal res.to_s, file_content
            object_test(res)
          end

          assert fake.verify
        end

        private

        def object_test(number_lookup_response)
          assert_equal number_lookup_response.status, '0'
          assert_equal number_lookup_response.msgid, 'CPASS_restapi_C00000000000000.0002'
          assert_equal number_lookup_response.to, '60123456789'
          assert_equal number_lookup_response.current_carrier.country, 'MY'
          assert_equal number_lookup_response.current_carrier.name, 'U Mobile'
          assert_equal number_lookup_response.current_carrier.network_code, '50218'
          assert_equal number_lookup_response.current_carrier.mcc, '502'
          assert_equal number_lookup_response.current_carrier.mnc, '18'
          assert_equal number_lookup_response.original_carrier.country, 'MY'
          assert_equal number_lookup_response.original_carrier.name, 'Maxis Mobile'
          assert_equal number_lookup_response.original_carrier.network_code, '50212'
          assert_equal number_lookup_response.original_carrier.mcc, '502'
          assert_equal number_lookup_response.original_carrier.mnc, '12'
          assert_equal number_lookup_response.ported, 'ported'
          assert_equal number_lookup_response.reachable, 'reachable'
        end
      end

    end
  end
end