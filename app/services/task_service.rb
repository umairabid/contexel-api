class TaskService

  def create_task(params, current_user)
    task = Task.new
    task.manager = current_user.manager
    populate_task_from_params task, params
    task_status = prepare_new_status params[:current_status], current_user
    task_keywords =  params[:keywords].map(&method(:create_or_update_keyword))
    save_task task, task_status, task_keywords
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

  def create_keyword(k)
    keyword = TaskKeyword.new
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

  def save_submission(params, writer)
    submission = params[:id] ? TaskSubmission.find(params[:id]) : TaskSubmission.new
    submission.submission = params[:submission][:submission]
    submission.task_id = params[:task_id]
    submission.writer_id = writer.id
    submission.save!
    submission
  end

  def update_task(params, current_user)
    task = Task.find(params[:id])
    populate_task_from_params task, params
    last_task_status = TaskStatus.where("task_id = ?", task.id).order(created_at: :desc).first
    task.task_keywords.destroy_all
    task_keywords =  params[:keywords].map(&method(:create_keyword))
    if last_task_status.status != params[:current_status]
      task_status = prepare_new_status params[:current_status], current_user
      save_task task, task_status, task_keywords
    else
      save_task task, nil, task_keywords
    end
    task
  end

  def save_task(task, status, keywords)
    Task.transaction do
      task.save!
      if status
        status.task = task
        status.save!
      end
      keywords.each do |kw|
        kw.task = task
        kw.save!
      end
    end
  end

end
