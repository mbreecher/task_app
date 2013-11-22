class AddFieldsToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :name, :string
    add_column :tasks, :instructions, :string
    add_column :tasks, :reference, :string
    add_column :tasks, :offset, :integer
    add_column :tasks, :csm_id, :integer
  end
end
