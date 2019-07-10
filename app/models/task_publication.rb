class TaskPublication < ApplicationRecord
  belongs_to :task_submission
  belongs_to :publishing_platform
end


