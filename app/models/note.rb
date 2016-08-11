class Note < ApplicationRecord
    before_create :encrypt_body
    @body

    def body=(str)
        @body = str
    end

    def body
        return nil if self.body_encrypted.nil?
        decipher = OpenSSL::Cipher.new('AES-256-CFB')
        decipher.decrypt
        decipher.key = Rails.application.config.pwhash
        decipher.update(self.body_encrypted) + decipher.final
    end

    def encrypt_body
        cipher = OpenSSL::Cipher.new('AES-256-CFB')
        cipher.encrypt
        cipher.key = Rails.application.config.pwhash
        raise 'hi' if @body.nil?
        self.body_encrypted = cipher.update(@body) + cipher.final
        self.body = nil
    end
end
