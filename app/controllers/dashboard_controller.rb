class DashboardController < ApplicationController

  before_action :set_service, :ensure_user

  def index
    dashboard = @service.send("#{current_user.role}_dashboard", current_user)
    render json: dashboard
  end


  private

  def set_service
    @service = DashboardService.new
  end

  def ensure_user
    unless current_user
      raise CanCan::AccessDenied
    end
  end

end
