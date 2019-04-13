class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :role, :profile
end
