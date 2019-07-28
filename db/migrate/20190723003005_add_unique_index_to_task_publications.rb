class AddUniqueIndexToTaskPublications < ActiveRecord::Migration[5.2]
  def self.up
    add_index :task_publications,
              [:task_submission_id, :publishing_platform_id],
              unique: true,
              name: 'submission_platform_unique_index'
  end

  def self.down
    remove_index :task_publications,
                 [:task_submission_id, :publishing_platform_id],
                 unique: true,
                 name: 'submission_platform_unique_index'
  end
end
