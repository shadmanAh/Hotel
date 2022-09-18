class AddSlugToHostels < ActiveRecord::Migration[7.0]
  def change
    add_column :hostels, :slug, :string
    add_index :hostels, :slug, unique: true
  end
end
