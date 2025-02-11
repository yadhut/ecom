class CreatePayments < ActiveRecord::Migration[7.2]
  def change
    create_table :payments do |t|
      t.decimal :amount, null: false
      t.string :status, default: 'pending'
      t.timestamps
    end
  end
end
