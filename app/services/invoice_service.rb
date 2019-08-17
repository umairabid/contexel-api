require 'erb'

class InvoiceService

  def generate_invoice(user, params)
    tasks = get_tasks_for_period user, params
    file = generate_pdf tasks, params
    save_invoice(file, user.profile, params)
  end

  def generate_pdf(tasks, params)
    view_params = get_params tasks, params
    file_handler = File.open(File.join(Rails.root, 'app', 'views', 'invoice.erb'))
    template = ERB.new(file_handler.read)
    WickedPdf.new.pdf_from_string(template.result(binding))
  end

  def get_params(tasks, params)
    chargeable_tasks = get_chargeable_tasks(tasks)
    sum = chargeable_tasks.reduce(0) {|result, current| result += current[:amount] }
    { chargeable_tasks: get_chargeable_tasks(tasks),
      writer: Writer.find(params[:writer_id]),
      period_from: params[:period_from],
      period_to: params[:period_to],
      sum: sum,
      date: Date.today }

  end

  def get_chargeable_tasks(tasks)
    tasks.each_with_index.map do |task, index|
      amount = task.payment_type == Task::PAYMENT_TYPE_FIXED ?
                   task.payment_value : task.payment_value * task.min_word
      { sr_no: index+1, amount: amount, title: task.title, words: task.min_word }
    end
  end

  def get_tasks_for_period(user, params)
    overlapping = get_overlapping_period(user, params)
    tasks = get_closed_tasks params
    raise "Invoice already exists" if overlapping.count > 0
    raise "No closed tasks in period" if tasks.count <= 0
    tasks
  end

  def get_overlapping_period(user, params)
    Invoice.where(
        "writer_id = ? and manager_id = ? and (period_from > ? or period_to < ?)",
        params[:writer_id], user.profile.id, params[:period_to], params[:period_from]
    )
  end

  def get_closed_tasks(params)
    writer = Writer.find(params[:writer_id])
    Task.joins(:task_statuses).where("tasks.user_id = ? and
            task_statuses.created_at >= ? and
            task_statuses.created_at <= ? and
            task_statuses.status = ?",
            writer.user_id, params[:period_from], params[:period_to], Task::STATUS_COMPLETED
    ).distinct
  end

  def save_invoice(file, manager, params)
    invoice = Invoice.new
    invoice.invoice_pdf.attach(
        io: StringIO.new(file),
        filename: "#{params[:period_from]}_#{params[:period_from]}_#{params[:writer_id]}.pdf",
        content_type: 'application/pdf',
    )
    invoice.manager = manager
    invoice.writer_id = params[:writer_id]
    invoice.period_from = params[:period_from]
    invoice.period_to = params[:period_to]
    invoice.save!
    invoice
  end

end
