class TaskSubmission < ApplicationRecord
  belongs_to :task
  belongs_to :writer
end