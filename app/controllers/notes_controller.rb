class NotesController < ApplicationController
    def index
        render locals: {notes: Note.all}
    end
end
