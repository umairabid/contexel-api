class CreateTaskSubmissions < ActiveRecord::Migration[5.2]
  def change
    create_table :task_submissions do |t|
      t.text :submission
      t.boolean :is_submitted, null: false, default: false
      t.references :task, {index: true, null: false, foreign_key: true}
      t.references :writer, {index: true, null: false, foreign_key: true}
      t.timestamps
    end
  end
end
