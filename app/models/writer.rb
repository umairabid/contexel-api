class Writer < ApplicationRecord
  belongs_to :user
  has_many :invoices
end
