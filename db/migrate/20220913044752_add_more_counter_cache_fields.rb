class AddMoreCounterCacheFields < ActiveRecord::Migration[7.0]
  def change
    add_column :hostels, :rooms_count, :integer, null: false, default: 0
    add_column :users, :hostels_count, :integer, null: false, default: 0
    add_column :users, :enrollments_count, :integer, null: false, default: 0
  end
end
