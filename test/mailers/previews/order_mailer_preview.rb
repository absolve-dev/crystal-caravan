# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/order_mailer/placed
  def placed
    OrderMailer.placed
  end

  # Preview this email at http://localhost:3000/rails/mailers/order_mailer/shipped
  def shipped
    OrderMailer.shipped
  end

  # Preview this email at http://localhost:3000/rails/mailers/order_mailer/cancelled
  def cancelled
    OrderMailer.cancelled
  end

end
