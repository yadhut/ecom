class CreateBookings < ActiveRecord::Migration[7.2]
  def change
    create_table :bookings do |t|
      t.string :reference_id, null:false
      t.references :user, null: false
      t.references :payment
      t.references :hotel, null: false
      t.date :booking_date, null: false
      t.date :checkin_date, null: false
      t.date :checkout_date, null: false
      t.decimal :amount, null: false
      t.string :status, default: 'pending'

      t.timestamps
    end
  end
end
