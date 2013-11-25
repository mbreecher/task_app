class AddCustomerIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :customer_id, :integer
    add_column :tasks, :due_date, :date
  end
end
