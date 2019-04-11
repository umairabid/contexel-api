class CreateWriter < ActiveRecord::Migration[5.2]
  def change
    create_table :writers do |t|
      t.integer :rate_per_word, null: false, default: 0
    end
  end
end
