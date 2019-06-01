class TaskSubmissionSerializer < ActiveModel::Serializer

  has_one :writer
  attributes :id, :created_at, :is_submitted, :submission
end
