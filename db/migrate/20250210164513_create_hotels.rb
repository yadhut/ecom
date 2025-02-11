class CreateHotels < ActiveRecord::Migration[7.2]
  def change
    create_table :hotels do |t|
      t.string :name, null: false
      t.text :address, null: false
      t.string :pin_code, null: false
      t.string :category, null: false
      t.string :status, default: 'available'

      t.timestamps
    end
  end
end
