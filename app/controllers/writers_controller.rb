class WritersController < ApplicationController

  authorize_resource

  before_action :set_service
  before_action :set_writer, only: [:update, :destroy]

  def index
    render json: @service.get_user_writers(current_user)
  end

  def create
    params[:writer][:manager_id] = current_user.profile.id
    writer = @service.create_writer params[:writer]
    render json: writer
  end

  def update
    writer = @service.update_writer @writer, params[:writer]
    render json: writer
  end

  def destroy
    @service.remove @writer
    render json: {status: "removed"}
  end

  private

  def set_service
    @service = WriterService.new
  end

  def set_writer
    @writer = Writer.find(params[:id])
  end

end