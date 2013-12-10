class AddSeniorInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_senior, :boolean, default: false
    add_column :users, :senior, :integer
  end
end
