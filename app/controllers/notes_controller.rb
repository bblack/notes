class NotesController < ApplicationController
    def index
        render locals: {notes: Note.all}
    end

    def show
        render locals: {note: Note.find(params[:id])}
    end
end
