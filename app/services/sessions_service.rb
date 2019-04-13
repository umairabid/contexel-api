class SessionsService

  def initialize
    @crypto_service = CryptoService.new
  end

  def login(params)
    user = User.find_by_email(params[:email])
    user.authenticate params[:password]
  end

end