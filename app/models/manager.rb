class Manager < ApplicationRecord

  CURRENCY_DOLLAR = 1

  belongs_to :user
  has_many :tasks
  has_many :teams
  has_many :writers
  has_many :publishing_platforms
  has_many :invoices

end
