class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :body
      t.references :task, index: true, foreign_key: {on_delete: :cascade}

      t.timestamps null: false
    end
  end
end
