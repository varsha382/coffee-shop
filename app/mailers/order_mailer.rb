class OrderMailer < ApplicationMailer
  def send_order_mail(order)
    @order = order

    mail(to: order.customer_email, subject:"#{@order.id}", message:"Successfully paid order")
  end
end