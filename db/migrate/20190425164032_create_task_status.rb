class CreateTaskStatus < ActiveRecord::Migration[5.2]
  def change
    create_table :task_statuses do |t|
      t.integer :status, null: false
      t.references :user, {index: true, null: false, foreign_key: true}
      t.references :task, {index: true, null: false, foreign_key: true}
      t.timestamps
    end
  end
end
