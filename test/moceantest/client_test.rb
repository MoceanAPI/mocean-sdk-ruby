require_relative 'mocean_testing'
module Moceansdk

  class ClientTest < MoceanTest::Test
    def test_client_creation_error_when_no_api_key_or_api_secret
      assert_raises Exceptions::RequiredFieldException do
        Client.new(Auth::Basic.new)
      end
      assert_raises Exceptions::RequiredFieldException do
        Client.new(Auth::Basic.new('', ''))
      end
      assert_raises Exceptions::RequiredFieldException do
        Client.new(Auth::Basic.new('test api key', ''))
      end
      assert_raises Exceptions::RequiredFieldException do
        Client.new(Auth::Basic.new('', 'test api secret'))
      end
      assert_raises Exceptions::RequiredFieldException do
        Client.new(Auth::Basic.new('test api key', nil))
      end
      assert_raises Exceptions::RequiredFieldException do
        Client.new(Auth::Basic.new(nil, 'test api secret'))
      end
    end

    def test_able_to_construct_obj
      Client.new(Auth::Basic.new('test api key', 'test api secret'))
    end

    def test_create_client_with_unsupported_auth
      assert_raises Exceptions::MoceanError do
        Client.new('test')
      end

      assert_raises Exceptions::MoceanError do
        Client.new(DummyCredential.new)
      end
    end
  end

  class DummyCredential < Auth::AbstractAuth
    def auth_method
      'dummy'
    end

    def params
      super
    end
  end

end