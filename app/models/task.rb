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
  has_many :task_submissions
  has_many :task_comments
  has_many :task_publications, through: :task_submissions

  def status
    sorted = task_statuses.sort { |a,b| b.created_at <=> a.created_at }
    sorted[0].status
  end
end

