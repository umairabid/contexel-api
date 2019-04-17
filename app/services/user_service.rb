require 'securerandom'

class UserService

  def prepare_new_user(params)
    user = User.new
    user.access_token = SecureRandom.hex
    user.password = params[:password]
    user.email = params[:email]
    user.name = params[:name]
    user
  end

end