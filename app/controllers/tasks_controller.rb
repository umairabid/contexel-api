class TasksController < ApplicationController

  authorize_resource

  before_action :set_task, only: :show

  before_action :set_service

  def index
    render json: @service.get_current_user_tasks(current_user)
  end

  def create
    task = @service.create_task params[:task], current_user
    render json: task
  end

  def update
    task = @service.update_task params[:task], current_user
    render json: task
  end

  def show
    render json: @task
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def set_service
    @service = TaskService.new
  end

end
