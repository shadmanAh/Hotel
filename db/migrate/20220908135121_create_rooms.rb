class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :title
      t.text :short_description
      t.text :description
      t.integer :price
      t.integer :capacity
      t.integer :size
      t.string :bed
      t.boolean :book
      t.date :check_in
      t.date :check_out
      t.string :view
      t.references :hostel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
