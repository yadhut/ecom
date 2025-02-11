class CreateCoupons < ActiveRecord::Migration[7.2]
  def change
    create_table :coupons do |t|
      t.references :user, null: false
      t.references :milestone, null: false
      t.string :status, null: false
      t.timestamps
    end
  end
end
