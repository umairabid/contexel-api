class TaskService

  def create_task(params, current_user)
    task = Task.new
    task.manager = current_user.manager
    populate_task_from_params task, params
    task_status = prepare_new_status params[:current_status], current_user
    task_keywords =  params[:keywords].map(&method(:create_or_update_keyword))
    Task.transaction do
      task.save!
      task_status.task = task
      task_status.save!
      task_keywords.each do |kw|
        kw.task = task
        kw.save!
      end
    end
    task
  end

  def populate_task_from_params(task, params)
    task.due_date = params[:due_date]
    task.title = params[:title]
    task.description = params[:description]
    task.due_date = params[:due_date]
    task.max_plagiarism = params[:max_plagiarism]
    task.max_mistakes = params[:max_mistakes]
    task.min_word = params[:min_word]
    task.payment_type = params[:payment_type]
    task.payment_value = params[:payment_value]
    task.user_id = params[:user_id]
  end

  def prepare_new_status(status, user)
    task_status = TaskStatus.new
    task_status.status = status
    task_status.user = user
    task_status
  end

  def create_or_update_keyword(k)
    keyword = k[:id].nil? ? TaskKeyword.new : TaskKeyword.find(k[:id])
    keyword.name = k[:name]
    keyword.density = k[:density]
    keyword
  end

  def get_current_user_tasks(user)
    case user.role
    when 'manager'
      Task.where(manager_id: user.profile.id)
    when 'writer'
      Task.where(user_id: user.id)
    else
      []
    end
  end

end
