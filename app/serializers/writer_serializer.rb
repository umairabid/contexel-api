class WriterSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :role, :rate_per_word, :avatar

  def name
    self.object.user.name
  end

  def email
    self.object.user.email
  end

  def role
    self.object.user.role
  end

  def avatar
    self.object.user.avatar.attached? &&
        Rails.application.routes.url_helpers.rails_blob_path(self.object.user.avatar)
  end

end
