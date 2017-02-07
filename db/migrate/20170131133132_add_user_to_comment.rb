class AddUserToComment < ActiveRecord::Migration
  def change
    add_reference :comments, :user, index: true, foreign_key: {on_delete: :cascade}
  end
end
