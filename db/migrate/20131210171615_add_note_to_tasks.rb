class AddNoteToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :note, :string
  end
end
