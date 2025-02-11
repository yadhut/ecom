require 'openssl'
require 'secret/keychain'

unless File.exist?(Rails.root.join('config', 'jwt_private_key.pem'))
  private_key = OpenSSL::PKey::RSA.new(2048)

  # Save private key to a file securely (e.g., encrypted file storage)
  File.write(Rails.root.join('config', 'jwt_private_key.pem'), private_key.to_pem)
end
Rails.configuration.x.private_key_path = Rails.root.join('config', 'jwt_private_key.pem')

kchain = Secret::Keychain.new(File.open(Rails.configuration.x.private_key_path))

Rails.application.config.x.keystore = kchain