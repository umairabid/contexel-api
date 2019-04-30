class TasksController < ApplicationController

  authorize_resource

  before_action :set_service

  def index
    render json: Task.all
  end

  def create
    task = @service.create_task params[:task], current_user
    render json: task
  end

  private

  def set_service
    @service = TaskService.new
  end

end
