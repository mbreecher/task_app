class CreateTaskSets < ActiveRecord::Migration
  def change
    create_table :task_sets do |t|
      t.string :name
      t.integer :csm_id

      t.timestamps
    end
  end
end
