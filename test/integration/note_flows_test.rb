require 'test_helper'

class NoteFlowsTest < ActionDispatch::IntegrationTest
  test 'index shows up' do
    get '/'
    assert_select 'table'
  end

  test 'note creation is denied on no password' do
    post '/notes', params: {title: 'movies', body: 'the godfather, star wars'}
    assert_response(401)
  end

  test 'note creation happens on correct password' do
    post '/notes', {
      params: {note: {title: 'movies', body: 'the godfather, star wars'}},
      headers: {Authorization: 'Basic ' + Base64::encode64(':orange')}
    }
    assert_redirected_to note_path(Note.last)
    note = Note.last
    assert_equal(note.title, 'movies')
    assert_equal(note.body, 'the godfather, star wars')
  end

  test 'cannot see note on bad password' do
    get note_path(Note.last)
    assert_response(401)
  end

  test 'can see note on correct password' do
    note = Note.create(title: 'fruits', body: 'apples, bananas')
    get note_path(note), headers: {Authorization: 'Basic ' + Base64::encode64(':orange')}
    assert_response(200)
    assert_select 'h1 span', 'fruits'
    assert_select 'pre', 'apples, bananas'
  end
end
