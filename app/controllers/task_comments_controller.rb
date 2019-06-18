class TaskCommentsController < ApplicationController
  authorize_resource

  before_action :set_service
  before_action :set_task, only: ["index"]

  def create
    comment = @service.save_comment(current_user, params)
    render json: comment
  end

  def index
    render json: @task.task_comments
  end

  def update
    comment = @service.save_comment(current_user, params)
    render json: comment
  end

  def destroy
    comment = TaskComment.find(params[:id])
    comment.destroy!
    render json: {success: true}
  end

  private

  def set_service
    @service = TaskService.new
  end

  def set_task
    @task = Task.find(params[:task_id])
  end

end
