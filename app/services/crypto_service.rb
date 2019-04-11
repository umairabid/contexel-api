class CryptoService

  def initialize
    # key = Rails.application.secrets.secret_key_base
    key = SecureRandom.random_bytes(32)
    @crypt = ActiveSupport::MessageEncryptor.new(key)
  end

  def encrypt(string)
    @crypt.encrypt_and_sign(string)
  end

  def decrypt(string)
    @crypt.decrypt_and_verify(string)
  end

end