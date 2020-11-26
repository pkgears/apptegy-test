class OrdersJob < ApplicationJob
  queue_as :default

  def perform(order)
    OrdersMailer.with(order: order).order_shipped
  end
end
