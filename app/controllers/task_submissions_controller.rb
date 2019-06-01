class TaskSubmissionsController < ApplicationController
  authorize_resource

  before_action :set_service
  before_action :set_task, only: ["index"]

  def view
    render json: TaskSubmission.find(params[:id])
  end

  def create
    submission = @service.save_submission params, current_user.profile
    render json: submission
  end

  def update
    submission = @service.save_submission params, current_user.profile
    render json: submission
  end

  def index
    render json: @task.task_submissions
  end

  private

  def set_service
    @service = TaskService.new
  end

  def set_task
    @task = Task.find(params[:task_id])
  end

end
