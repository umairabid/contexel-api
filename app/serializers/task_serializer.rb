class TaskSerializer < ActiveModel::Serializer

  has_one :user, key: :assignee, serializer: TaskUserSerializer
  has_many :task_keywords, key: :keywords
  has_many :task_statuses, key: :statuses

  attributes :id,
             :description,
             :title,
             :due_date,
             :max_plagiarism,
             :max_mistakes,
             :min_word,
             :payment_type,
             :payment_value,
             :user_id


end

