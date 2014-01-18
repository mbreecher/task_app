class CreateFeederTasks < ActiveRecord::Migration
  def change
    create_table :feeder_tasks do |t|
      t.string :name
      t.string :instructions
      t.string :reference
      t.integer :offset
      t.integer :task_set_id

      t.timestamps
    end
  end
end
