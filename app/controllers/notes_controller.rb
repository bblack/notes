class NotesController < ApplicationController
    before_action :authenticate, only: [:show, :create]

    def index
        render locals: {notes: Note.all}
    end

    def show
        render locals: {note: Note.find(params[:id])}
    end

    def new
        render locals: {note: Note.new}
    end

    def create
        note = Note.create(note_params)
        redirect_to(note_path(note))
    end

    private

    def note_params
        params.require(:note).permit(:title, :body)
    end

    def authenticate
        authenticate_or_request_with_http_basic do |user, pass|
            salt = 'victory prima pils!@#$%^&*()'
            checksum = Digest::MD5.hexdigest(pass + salt)
            return checksum == "ee1c89c6bef7d3b818b75750964a07af"
        end
    end
end
