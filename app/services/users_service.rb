require 'securerandom'

class UsersService

  def initialize
    @crypto_service = CryptoService.new
  end

  def create_user(u_params, p_params)
    user = User.new u_params
    user.password = @crypto_service.encrypt u_params[:password]
    user.access_token = SecureRandom.hex
    profile = u_params[:role] == User::ROLE_MANAGER ? Manager.new(p_params) : Writer.new(p_params)
    User.transaction do
      user.save!
      profile.user_id = user.id
      profile.save!
    end
    user
  end
end