class Order < ApplicationRecord
  belongs_to :offer, optional: true
  belongs_to :user, optional: true
  has_many :order_details, class_name: "OrderDetail", inverse_of: 'order'

  accepts_nested_attributes_for :order_details, allow_destroy: true
  before_validation :apply_offer
  before_save :update_tax_and_amount
  after_save :send_email_to_user, if: :paid?
  enum status: {
    inprogress: "Inprogress", canceled: "Canceled", paid: "Paid"
  }
  # validates_presence_of :customer_name, :customer_email
  # validates_presence_of :order_details

  private

  def send_email_to_user
    OrderMailer.send_order_mail(self).deliver_later!(wait: 5.minutes)
  end


  def apply_offer
    item_ids = order_details.map(&:item_id)
    offer_by_base_itme = Offer.where(base_item_id: item_ids)
    offer_by_child_itme = Offer.where(child_item_id: item_ids)
    offers = offer_by_base_itme.or(offer_by_child_itme)
    self.offer = offers.find do |offer|
      base_order_detail = order_details.find { |order_detail| offer.base_item_id == order_detail.item_id }
      if base_order_detail.present? && !base_order_detail.marked_for_destruction?
        if base_order_detail.quantity >= offer.base_item_quantity
          child_order_detail = order_details.find { |order_detail| offer.child_item_id == order_detail.item_id }
          if offer.is_discount_available
            if child_order_detail.present? && child_order_detail.quantity >= offer.child_item_quantity
              offer
            end
          elsif offer.child_item_id.present? && child_order_detail.present? && !child_order_detail.marked_for_destruction? && child_order_detail.quantity >= offer.child_item_quantity
            offer
          elsif offer.child_item_id.blank?
            offer
          end
        end
      end
    end
  end

  def update_tax_and_amount
    self.amount = self.order_details.inject(0) {|sum, detail| sum += detail.amount  }
    self.total_tax = self.order_details.inject(0) {|sum, detail| sum += detail.total_tax  }
    self.total_amount = self.order_details.inject(0) {|sum, detail| sum += detail.total_amount.to_f  }
    self.total_discount = self.order_details.inject(0) {|sum, detail| sum += detail.discount_amount.to_f  }
  end
end
