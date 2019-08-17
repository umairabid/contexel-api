class InvoiceSerializer < ActiveModel::Serializer
  attributes :id, :period_from, :period_to, :writer_name, :invoice_download_link

  def writer_name
    self.object.writer.user.name
  end

  def invoice_download_link
    Rails.application.routes.url_helpers.rails_blob_path(self.object.invoice_pdf, only_path: true)
  end

end
