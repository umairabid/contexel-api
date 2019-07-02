class PublishingPlatform < ApplicationRecord

  has_secure_password

  belongs_to :manager

  WORDPRESS = 1
  FACEBOOK = 2
  TWITTER = 3

  enum name: { wordpress: 1, facebook: 2, twitter: 3 }

end