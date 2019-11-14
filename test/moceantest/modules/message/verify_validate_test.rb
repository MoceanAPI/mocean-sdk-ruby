require_relative '../../mocean_testing'
module Moceansdk
  module Modules
    module Message

      class VerifyValidateTest < MoceanTest::Test
        def test_setter
          verify_validate = MoceanTest::TestingUtils.client_obj.verify_validate

          verify_validate.reqid = 'test reqid'
          refute verify_validate.params['mocean-reqid'].nil?
          assert_equal 'test reqid', verify_validate.params['mocean-reqid']

          verify_validate.code = 'test code'
          refute verify_validate.params['mocean-code'].nil?
          assert_equal 'test code', verify_validate.params['mocean-code']

          verify_validate.resp_format = 'json'
          refute verify_validate.params['mocean-resp-format'].nil?
          assert_equal 'json', verify_validate.params['mocean-resp-format']
        end

        def test_send
          fake = Minitest::Mock.new
          fake.expect :call, 'testing only', [String, String, Hash]

          transmitter_mock = Moceansdk::Modules::Transmitter.new
          transmitter_mock.stub(:request_and_parse_body, lambda {|method, uri, params|
            assert_equal method, 'post'
            assert_equal uri, '/verify/check'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)

            assert_raises Moceansdk::Exceptions::RequiredFieldException do
              client.verify_validate.send
            end

            assert_equal(client.verify_validate.send(
                'mocean-reqid': 'test reqid', 'mocean-code': 'test code'
            ), 'testing only')
          end

          assert fake.verify
        end

        def test_json_response
          file_content = File.read(MoceanTest::TestingUtils.resource_file_path('verify_code.json'))
          fake = Minitest::Mock.new
          transmitter_mock = Moceansdk::Modules::Transmitter.new

          fake.expect :call, transmitter_mock.format_response(file_content), [String, String, Hash]
          transmitter_mock.stub(:request_and_parse_body, lambda {|method, uri, params|
            assert_equal method, 'post'
            assert_equal uri, '/verify/check'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)
            res = client.verify_validate.send(
                'mocean-reqid': 'test reqid', 'mocean-code': 'test code'
            )

            assert_equal res.to_s, file_content
            object_test(res)
          end

          assert fake.verify
        end

        def test_xml_response
          file_content = File.read(MoceanTest::TestingUtils.resource_file_path('verify_code.xml'))
          fake = Minitest::Mock.new
          transmitter_mock = Moceansdk::Modules::Transmitter.new

          fake.expect :call, transmitter_mock.format_response(file_content, true, '/verify/check'), [String, String, Hash]
          transmitter_mock.stub(:request_and_parse_body, lambda {|method, uri, params|
            assert_equal method, 'post'
            assert_equal uri, '/verify/check'
            fake.call(method, uri, params)
          }) do
            client = MoceanTest::TestingUtils.client_obj(transmitter_mock)
            res = client.verify_validate.send(
                'mocean-reqid': 'test reqid', 'mocean-code': 'test code'
            )

            assert_equal res.to_s, file_content
            object_test(res)
          end

          assert fake.verify
        end

        private

        def object_test(verify_validate_response)
          assert_equal verify_validate_response.to_hash, verify_validate_response.inspect
          assert_equal verify_validate_response.status, '0'
          assert_equal verify_validate_response.reqid, 'CPASS_restapi_C0000002737000000.0002'
        end
      end

    end
  end
end