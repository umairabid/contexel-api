class UsersController < ApplicationController

  before_action :set_service

  def index
    render json: User.all
  end

  def create
    params[:user][:role] = User::ROLE_MANAGER
    user = @service.create_user user_params, profile_params
    render json: user
  end

  private

  def set_service
    @service = UsersService.new
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :role)
  end

  def profile_params
    params.fetch(:user).fetch(:profile).permit(:currency)
  end

end