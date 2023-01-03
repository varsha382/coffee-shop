class Order < ApplicationRecord
  belongs_to :offer, optional: true
  belongs_to :user, optional: true
  has_many :order_details, class_name: "OrderDetail", inverse_of: 'order'

  accepts_nested_attributes_for :order_details, allow_destroy: true
  before_save :update_tax_and_amount
  after_save :send_email_to_user, if: :paid?
  enum status: {
    inprogress: "Inprogress", canceled: "Canceled", paid: "Paid"
  }
  # validates_presence_of :customer_name, :customer_email
  validates_presence_of :order_details

  private

  def send_email_to_user
    OrderMailer.send_order_mail(self).deliver_later!(wait: 5.minutes)
  end

  def update_tax_and_amount
    self.amount = self.order_details.inject(0) {|sum, detail| sum += detail.amount  }
    self.total_tax = self.order_details.inject(0) {|sum, detail| sum += detail.total_tax  }
    self.total_amount = self.order_details.inject(0) {|sum, detail| sum += detail.total_amount.to_f  }
    self.total_discount = self.order_details.inject(0) {|sum, detail| sum += detail.discount_amount.to_f  }
  end
end
