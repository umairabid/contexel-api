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

  def update_writer(writer, params)
    user = writer.user
    user.name = params[:name]
    user.email = params[:email]
    writer.rate_per_word = params[:rate_per_word]
    User.transaction do
      user.save!
      writer.save!
    end
    writer
  end

  def remove(writer)
    User.transaction do
      user = writer.user
      User.transaction do
        writer.destroy
        user.destroy
      end
    end
  end

  def prepare_writer(params)
    writer = Writer.new
    writer.rate_per_word = params[:rate_per_word]
    writer.manager_id = params[:manager_id]
    writer
  end

  def get_user_writers(user)
    case user.role
    when 'manager'
      Writer.where(manager_id: user.profile.id)
    when 'writer'
      Writer.where(id: user.profile.id)
    else
      []
    end
  end

end
