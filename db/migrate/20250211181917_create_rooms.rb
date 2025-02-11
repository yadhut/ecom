class CreateRooms < ActiveRecord::Migration[7.2]
  def change
    create_table :rooms do |t|
      t.string :type, null: false
      t.text :description
      t.integer :availablity, null: false
      t.decimal :price, null: false
      t.references :hotel
      t.timestamps
    end
  end
end
