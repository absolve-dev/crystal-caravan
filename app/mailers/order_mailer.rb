class OrderMailer < ApplicationMailer
  
  default :from => "ruby-carbuncle@absolvegaming.com"
  
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.placed.subject
  #
  def placed(order)
    @order = order
    mail to: order.email
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.shipped.subject
  #
  def shipped(order)
    @order = order
    mail to: order.email
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.cancelled.subject
  #
  def cancelled(order)
    @order = order
    mail to: order.email
  end
end
