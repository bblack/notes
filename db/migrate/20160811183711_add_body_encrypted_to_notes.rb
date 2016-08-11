class AddBodyEncryptedToNotes < ActiveRecord::Migration[5.0]
  def change
    add_column :notes, :body_encrypted, :binary
    remove_column :notes, :body
  end
end
