class TaskPublicationsController < ApplicationController
  authorize_resource

  before_action :set_task, only: [:index]
  before_action :set_service
  before_action :set_publication, only: [:destroy]

  def index
    render json: @task.task_publications
  end

  def create
    render json: @service.publish(params)
  end

  def destroy
    @publication.destroy
    render json: {status: "removed"}
  end

  private

  def set_task
    @task = Task.find params[:task_id]
  end

  def set_service
    @service = PublishingPlatformService.new
  end

  def set_publication
    @publication = TaskPublication.find(params[:id])
  end

end