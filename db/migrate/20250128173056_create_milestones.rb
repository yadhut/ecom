class CreateMilestones < ActiveRecord::Migration[7.2]
  def change
    create_table :milestones do |t|
      t.string :code, null: false
      t.integer :discount, null: false
      t.integer :life_span, null: false
      t.integer :milestones_days, null: false
      t.timestamps
    end
  end
end
