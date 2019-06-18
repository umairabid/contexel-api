class TaskCommentSerializer < ActiveModel::Serializer

  has_one :user
  attributes :id, :created_at, :updated_at, :comment
end

