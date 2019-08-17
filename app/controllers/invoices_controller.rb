class InvoicesController < ApplicationController

  authorize_resource

  before_action :set_writer, only: :create
  before_action :set_service

  def index
    render json: current_user.profile.invoices
  end

  def create
    invoice = @service.generate_invoice current_user, params[:invoice]
    render html: invoice
  end



  private

  def set_writer
    writer = Writer.find(params[:invoice][:writer_id])
    raise "Writer does not belong to manager" if writer.manager_id != @current_user.profile.id
  end

  def set_service
    @service = InvoiceService.new
  end

end