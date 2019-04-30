class CreateTaskKeywords < ActiveRecord::Migration[5.2]
  def change
    create_table :task_keywords do |t|
      t.string :name, null: false
      t.integer :density, null: false
      t.references :task, {index: true, null: false, foreign_key: true}
      t.timestamps
    end
  end
end
