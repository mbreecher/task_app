class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.date :start
      t.date :fiscal_ye
      t.date :next_per_end
      t.date :next_target
      t.integer :csm_id

      t.timestamps
    end
  end
end
