class Note < ApplicationRecord
    def body(key)
        decipher = OpenSSL::Cipher.new('AES-256-CFB')
        decipher.decrypt
        decipher.key = key
        decipher.update(self.body_encrypted) + decipher.final
    end
end
