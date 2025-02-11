class CreateInvoices < ActiveRecord::Migration[7.2]
  def change
    create_table :invoices do |t|
      t.references :booking
      t.string :invoice_no, null: false
      t.json :metadata

      t.timestamps
    end
  end
end
