class SessionsController < ApplicationController

  before_action :set_service

  def create
    user = @service.login params
    user ?
        render(json: user, adapter: nil) :
        render(json: {error: "Invalid password"}, status: 400)
  end

  private

  def set_service
    @service = SessionService.new
  end

end