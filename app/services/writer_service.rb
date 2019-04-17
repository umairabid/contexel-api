class WriterService

  def initialize
    @user_service = UserService.new
  end

  def create_writer(params)
    user = @user_service.prepare_new_user params
    user.role = User::ROLE_WRITER
    profile = prepare_writer params
    User.transaction do
      user.save!
      profile.user_id = user.id
      profile.save!
    end
    profile
  end

  def prepare_writer(params)
    writer = Writer.new
    writer.rate_per_word = params[:rate_per_word]
    writer
  end

end
