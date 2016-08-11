class Note < ApplicationRecord
    def self.encrypt(key, plaintext)
        decipher = OpenSSL::Cipher.new('AES-256-CFB')
        decipher.decrypt
        decipher.key = key
        decipher.update(plaintext) + decipher.final
    end

    def body(key)
        Note.encrypt(key, self.body_encrypted)
    end
end
