class ManagersController < ApplicationController
  before_action :set_service

  def create
    user = @service.create_manager params[:manager]
    render(json: user, adapter: nil)
  end

  def set_service
    @service = ManagerService.new
  end

end