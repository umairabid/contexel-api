class User < ApplicationRecord

  ROLE_WRITER = 2
  ROLE_MANAGER = 1

  enum role: { manager: 1, writer: 2 }

  has_one :writer
  has_one :manager

end
