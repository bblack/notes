class NotesController < ApplicationController
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
end
