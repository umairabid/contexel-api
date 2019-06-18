class CreateTaskComments < ActiveRecord::Migration[5.2]
  def change
    create_table :task_comments do |t|
      t.text :comment
      t.references :task, {index: true, null: false, foreign_key: true}
      t.references :user, {index: true, null: false, foreign_key: true}
      t.timestamps
    end
  end
end
