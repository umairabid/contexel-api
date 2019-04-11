class CreateManager < ActiveRecord::Migration[5.2]
  def change
    create_table :managers do |t|
      t.string :company
      t.integer :currency, null: false, default: 1
      t.references :user, index: true, null: false, foreign_key: true
    end
  end
end
