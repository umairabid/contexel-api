class ManagerService

  def initialize
    @user_service = UserService.new
  end

  def create_manager(params)
    user = @user_service.prepare_new_user params
    user.role = User::ROLE_MANAGER
    User.transaction do
      profile = prepare_manager params
      user.save!
      profile.user_id = user.id
      profile.save!
    end
    user
  end

  def prepare_manager(params)
    manager = Manager.new
    manager.company = params[:company]
    manager.currency = params[:currency] || Manager::CURRENCY_DOLLAR
    manager
  end

end
