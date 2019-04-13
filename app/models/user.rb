class User < ApplicationRecord

  has_secure_password

  ROLE_WRITER = 2
  ROLE_MANAGER = 1

  enum role: { manager: 1, writer: 2 }

  has_one :writer
  has_one :manager

  def profile
    case role
    when 'manager' then manager
    when 'writer' then writer
    else raise NotImplementedError
    end
  end

end
