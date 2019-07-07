class DashboardService

  def manager_dashboard(user)
    {
        summary: manager_summary(user.profile),
        tasks: tasks_by_status_count(user.profile),
        teams: teams_by_writer_count(user.profile),
        writers: writers_by_task_count(user.profile),
    }
  end

  def writer_dashboard(user)
    {
        summary: writer_summary(user.profile),
        tasks: tasks_by_status_count(user),
    }
  end

  private

  def manager_summary(manager)
    {
        Tasks: manager.tasks.count,
        Writers: manager.writers.count,
        Teams: manager.teams.count,
    }
  end

  def writer_summary(writer)
    {
        Tasks: writer.user.tasks.count
    }
  end

  def tasks_by_status_count(profile)
    tasks = {}
    profile.tasks.each do |task|
      if tasks[task.status]
        tasks[task.status] = tasks[task.status] + 1
      else
        tasks[task.status] = 1
      end
    end
    tasks
  end

  def teams_by_writer_count(manager)
    teams = {}
    manager.teams.each do |team|
      teams[team.name] = team.writers.count
    end
    teams
  end

  def writers_by_task_count(manager)
    writers = {}
    manager.writers.each do |writer|
      writers[writer.user.name.to_s] = writer.user.tasks.count
    end
    writers
  end

end
