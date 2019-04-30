class TaskSerializer < ActiveModel::Serializer

  has_one :user, key: :assignee, serializer: TaskUserSerializer

  attributes :id, :title, :task_statuses, :due_date

end

