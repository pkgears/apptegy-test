# frozen_string_literal: true

# OrderMailer
class OrdersMailer < ApplicationMailer
  def order_shipped
    order = params[:order]
    order.recipients.each do |recipient|
      email_to_recipient(order, recipient)
    end
  end

  private

  def email_to_recipient(order, recipient)
    @recipient = recipient
    @order = order
    mail(to: @recipient.email, subject: 'You has an order shipped').deliver!
  end
end
