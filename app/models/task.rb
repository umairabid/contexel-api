class Task < ApplicationRecord

  STATUS_OPEN = 1
  STATUS_IN_PROGRESS = 2
  STATUS_SUBMITTED = 3
  STATUS_COMPLETED = 4

  PAYMENT_TYPE_FIXED = 1
  PAYMENT_TYPE_PPW = 2

  belongs_to :manager
  belongs_to :user #assignee
  has_many :task_statuses
  has_many :task_keywords
end

