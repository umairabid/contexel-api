class SessionsController < ApplicationController

  before_action :set_service

  def create
    user = @service.login params
    user ?
        render(json: user) :
        render(json: {error: "Invalid password"}, status: 400)
  end

  private

  def set_service
    @service = SessionsService.new
  end

end