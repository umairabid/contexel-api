class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :description
      t.datetime :due_date, null: false
      t.integer :max_plagiarism
      t.integer :max_mistakes
      t.integer :min_word, null: false, default: 0
      t.integer :payment_type, null: false
      t.integer :payment_value, null: false
      t.references :user, {index: true, null: false, foreign_key: true}
      t.references :manager, {index: true, null: false, foreign_key: true}
      t.timestamps
    end
  end
end
