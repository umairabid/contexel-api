class CreateWriter < ActiveRecord::Migration[5.2]
  def change
    create_table :writers do |t|
      t.integer :rate_per_word, null: false, default: 0
      t.references :user, index: { unique: true }, null: false, foreign_key: true
    end
  end
end
