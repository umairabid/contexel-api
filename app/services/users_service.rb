require 'securerandom'

class UsersService

  def initialize
    @crypto_service = CryptoService.new
  end

  def create_user(u_params, p_params)
    user = User.new u_params
    user.access_token = SecureRandom.hex
    user.password = u_params[:password]
    profile = u_params[:role] == User::ROLE_MANAGER ? Manager.new(p_params) : Writer.new(p_params)
    User.transaction do
      user.save!
      profile.user_id = user.id
      profile.save!
    end
    user
  end
end