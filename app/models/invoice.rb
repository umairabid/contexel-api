class Invoice < ApplicationRecord

  has_one_attached :invoice_pdf

  belongs_to :manager
  belongs_to :writer

end

