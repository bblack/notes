class AddTitleToNote < ActiveRecord::Migration[5.0]
  def change
    add_column :notes, :title, :text
  end
end
