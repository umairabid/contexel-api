class CreateManager < ActiveRecord::Migration[5.2]
  def change
    create_table :managers do |t|
      t.string :company
      t.integer :currency, null: false, default: 1
      t.references :user, index: { unique: true }, null: false, foreign_key: true
      t.timestamps
    end
  end
end
