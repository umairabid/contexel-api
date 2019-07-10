class TaskSubmission < ApplicationRecord
  belongs_to :task
  belongs_to :writer
  has_many :task_publications
end