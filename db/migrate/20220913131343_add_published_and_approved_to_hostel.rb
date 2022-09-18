class AddPublishedAndApprovedToHostel < ActiveRecord::Migration[7.0]
  def change
    add_column :hostels, :published, :boolean, default: false
    add_column :hostels, :approved, :boolean, default: false
  end
end
