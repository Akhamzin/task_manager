class AddAdminToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :admin_id, :integer
    add_index :tasks, :admin_id
    add_foreign_key :tasks, :users, column: :admin_id, primary_key: :id, on_delete: :cascade
  end
end
