class CreateTaskPublications < ActiveRecord::Migration[5.2]
  def change
    create_table :task_publications do |t|
      t.references :task_submission, {index: true, null: false, foreign_key: true}
      t.references :publishing_platform, {index: true, null: false, foreign_key: true}
      t.string :link, {limit: 1000}
      t.timestamps
    end
  end
end
