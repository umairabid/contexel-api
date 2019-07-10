class TaskPublicationsController < ApplicationController
  authorize_resource

  before_action :set_task, only: [:index]

  def index
    render json: @task.task_publications
  end

  private

  def set_task
    @task = Task.find params[:task_id]
  end

end