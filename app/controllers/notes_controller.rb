class NotesController < ApplicationController
    before_action :authenticate, only: [:show, :create]

    def index
        rows = Note.all.each_slice(4).to_a
        render locals: {notes: Note.all, rows: rows}
    end

    def show
        note = Note.find(params[:id])

        decipher = OpenSSL::Cipher.new('AES-256-CFB')
        decipher.decrypt
        decipher.key = @key

        render locals: {note: note}
    end

    def new
        render locals: {note: Note.new}
    end

    def create
        cipher = OpenSSL::Cipher.new('AES-256-CFB')
        cipher.encrypt
        cipher.key = @key
        body_encrypted = cipher.update(note_params[:body]) + cipher.final

        note = Note.create(
            note_params
            .except(:body)
            .merge(body_encrypted: body_encrypted)
        )
        redirect_to(note_path(note))
    end

    private

    def note_params
        params.require(:note).permit(:title, :body)
    end

    def authenticate
        authenticate_or_request_with_http_basic do |user, pass|
            salt = 'victory prima pils!@#$%^&*()'
            @key = Digest::MD5.hexdigest(pass + salt)
            Digest::MD5.hexdigest(@key) == Rails.application.config.keyhash
        end
    end
end
