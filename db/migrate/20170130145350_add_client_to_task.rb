class AddClientToTask < ActiveRecord::Migration
  def change
  	add_column :tasks, :client_id, :integer
    add_index :tasks, :client_id
    add_foreign_key :tasks, :users, column: :client_id, primary_key: :id, on_delete: :cascade
  end
end
