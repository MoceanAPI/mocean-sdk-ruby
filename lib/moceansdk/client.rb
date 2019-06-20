module Moceansdk

  class Client
    def initialize(obj_auth, options = nil)
      unless obj_auth.is_a? Auth::AbstractAuth
        raise Exceptions::MoceanError, 'auth object must extend AbstractAuth'
      end

      if obj_auth.auth_method.casecmp('basic').zero?
        if Utils.nil_or_empty?(obj_auth.params['mocean-api-key']) || Utils.nil_or_empty?(obj_auth.params['mocean-api-secret'])
          raise Exceptions::RequiredFieldException, "api key and api secret for client object can't be empty"
        end
      else
        raise Exceptions::MoceanError, 'unsupported auth method'
      end

      @transmitter = if options.is_a? Modules::Transmitter
                       options
                     else
                       Modules::Transmitter.new(options)
                     end

      @obj_auth = obj_auth
    end

    def sms
      Modules::Message::Sms.new(@obj_auth, @transmitter)
    end

    def flash_sms
      sms = Modules::Message::Sms.new(@obj_auth, @transmitter)
      sms.mclass = 1
      sms.alt_dcs = 1
      sms
    end

    def pricing
      Modules::Account::Pricing.new(@obj_auth, @transmitter)
    end

    def balance
      Modules::Account::Balance.new(@obj_auth, @transmitter)
    end

    def message_status
      Modules::Message::MessageStatus.new(@obj_auth, @transmitter)
    end

    def verify_request
      Modules::Message::VerifyRequest.new(@obj_auth, @transmitter)
    end

    def verify_validate
      Modules::Message::VerifyValidate.new(@obj_auth, @transmitter)
    end

    def number_lookup
      Modules::NumberLookup::NumberLookup.new(@obj_auth, @transmitter)
    end
  end

end
