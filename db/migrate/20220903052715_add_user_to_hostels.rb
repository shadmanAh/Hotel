class AddUserToHostels < ActiveRecord::Migration[7.0]
  def change
    add_reference :hostels, :user, null: false, foreign_key: true
  end
end
