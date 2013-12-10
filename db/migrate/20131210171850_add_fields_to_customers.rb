class AddFieldsToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :single_source, :boolean
    add_column :customers, :note, :string
    add_column :customers, :xbrl_service, :string
  end
end
