require 'openssl'

module Secret
  class Keychain

    def initialize(private_key)
      OpenSSL::PKey.read(private_key).tap do | key |
        @private_key = key
        @public_key = key.public_key
      end
    end

    def private_key
      @private_key
    end

    def public_key
      @public_key
    end
  end
end