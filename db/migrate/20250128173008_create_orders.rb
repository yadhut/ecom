class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.string :order_id, null: false
      t.references :user, null: false
      t.decimal :amount, null: false
      t.string  :type, null: false

      t.timestamps
    end
  end
end
