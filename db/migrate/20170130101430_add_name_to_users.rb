class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string, null: false
    add_column :users, :middle_name, :string, null: false
    add_column :users, :last_name, :string, null: false
    add_column :users, :company_name, :string, null: false
    add_column :users, :phone_number, :string, null: false
  end
end
