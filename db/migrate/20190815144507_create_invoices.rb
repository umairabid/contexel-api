class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.references :manager, index: true, null: false, foreign_key: true
      t.references :writer, index: true, null: false, foreign_key: true
      t.datetime :period_from, null: false
      t.datetime :period_to, null: false
      t.timestamps
    end
  end
end
