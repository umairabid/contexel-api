class TaskSubmissionSerializer < ActiveModel::Serializer

  has_one :writer
  attributes :id, :title, :created_at, :updated_at, :is_submitted, :submission
end
