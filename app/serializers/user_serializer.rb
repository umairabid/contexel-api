class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :role, :profile, :avatar

  def avatar
    self.object.avatar.attached? &&
        Rails.application.routes.url_helpers.rails_blob_path(self.object.avatar)
  end

end
