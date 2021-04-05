# frozen_string_literal: true

require 'rbnacl'
require 'base64'

# ModernSymmetricCipher
module ModernSymmetricCipher
  def self.generate_new_key
    # TODO: Return a new key as a Base64 string
    # new key
    @key = RbNaCl::Random.random_bytes(RbNaCl::SecretBox.key_bytes)
  end

  def self.encrypt(document, _key)
    # TODO: Return an encrypted string
    #       Use base64 for ciphertext so that it is sendable as text
    simple_box = RbNaCl::SimpleBox.from_secret_key(generate_new_key)
    ciphertext = simple_box.encrypt(document.to_s)
    Base64.strict_encode64(ciphertext)
  end

  def self.decrypt(encrypted_cc, _key)
    # TODO: Decrypt from encrypted message above
    #       Expect Base64 encrypted message and Base64 key
    ciphertext = Base64.strict_decode64(encrypted_cc)
    # after running generate_new_key, we can use @key
    simple_box = RbNaCl::SimpleBox.from_secret_key(@key)
    # plaintext
    simple_box.decrypt(ciphertext)
  end
end
