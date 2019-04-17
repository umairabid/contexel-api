class WritersController < ApplicationController

  authorize_resource

  before_action :set_service

  def index
    render json: Writer.all
  end

  def create
    writer = @service.create_writer params[:writer]
    render json: writer
  end

  private

  def set_service
    @service = WriterService.new
  end

end