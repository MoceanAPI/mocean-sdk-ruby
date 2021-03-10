require_relative '../../../mocean_testing'
module Moceansdk
  module Modules
    module Command
      module McObject

        class SendSMSTest < MoceanTest::Test
          def test_params
            params = {
                'from': {
                  'type': 'phone_num',
                  'id': 'from number'
                },
                'to':  {
                  'type': 'phone_num',
                  'id': 'to number'
                },
                'content': {
                  'type': 'text',
                  'text': 'test text'
                },
                'action': 'send-sms'
            }
            assert_equal params, SendSMS.new(params).get_request_data

            sendsms_test = SendSMS.new
            sendsms_test.from 'from number'
            sendsms_test.to 'to number'
            sendsms_test.content 'test text'

            assert_equal params, sendsms_test.get_request_data
          end

          def test_if_required_field_not_set
            assert_raises Moceansdk::Exceptions::RequiredFieldException do
              SendSMS.new.get_request_data
            end
          end
        end

      end
    end
  end
end