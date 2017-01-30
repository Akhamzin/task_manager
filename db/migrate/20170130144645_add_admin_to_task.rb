class AddAdminToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :admin_id, :integer, null: false
    add_index :tasks, :admin_id
    add_foreign_key :tasks, :users, column: :admin_id, primary_key: :id
  end
end
