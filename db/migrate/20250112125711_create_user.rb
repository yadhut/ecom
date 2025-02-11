class CreateUser < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string  :uid, null: false
      t.string  :first_name, null: false
      t.string  :last_name
      t.date    :dob, null: false
      t.string  :email,null: false
      t.string  :phone_number
      t.string  :password_digest, null: false
      t.string  :role, default: "member", null: false
      t.string  :state, default: "pending", null: false

      t.timestamps
    end
  end
end
