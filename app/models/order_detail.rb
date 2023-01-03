class OrderDetail < ApplicationRecord
  belongs_to :order, inverse_of: 'order_details'
  belongs_to :item
  validates_presence_of :quantity
  after_validation :apply_offer
  after_validation :update_tax_and_amount
  validates_length_of :quantity, minimum: 1, message: "must be grater than 1"

  delegate :name, to: :item, prefix: :item

  private
  def update_tax_and_amount
    if !is_free_item
      self.amount = self.item.amount * self.quantity.to_i
      self.total_tax = self.amount * item.rate / 100
      self.total_amount = (amount + total_tax) - discount_amount.to_f
    end
  end
  
  def apply_offer
    offer = order.offer
    if offer.present? && offer.is_discount_available && (offer.offer_applied_on_item_type.id == item.item_type_id)
      self.discount_amount = (self.item.amount * self.quantity.to_i * offer.discount_percent) / 100
      order_detail = order.order_details.find{|order_detail| order_detail if order_detail.is_free_item }
      order_detail.mark_for_destruction if order_detail
    elsif offer.present? && !offer.is_discount_available && !order.order_details.find{|order_detail| order_detail.item_id == offer.free_item_id}
      self.discount_amount = 0
      order.order_details.build({
        item_id: offer.free_item_id,
        amount: 0,
        total_tax: 0,
        discount_amount: 0,
        is_free_item: true,
        quantity: 1,
        total_amount: 0
      })
    elsif offer.blank?
      order_detail = order.order_details.find{|order_detail| order_detail if order_detail.is_free_item }
      order_detail.mark_for_destruction if order_detail
      self.discount_amount = 0
    end
  end
end
