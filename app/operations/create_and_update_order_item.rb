class CreateAndUpdateOrderItem
  class << self
    def call(user, order_detail_params)
      begin
        order = prosess(user, order_detail_params)
        {status: :success, order: order.as_json(include: [:order_details, :offer]), errors: [], message: "Added/Updated Item into Cart"}
      rescue => exception
        {status: :failed, errors: exception.message, message: "Failed to add item"}
      end
    end

    private
    def prosess(user, order_detail_params)
      ActiveRecord::Base.transaction do
        order = get_order(user)
        update_offer_for(order)
        order = build_and_assign_order(order, order_detail_params)
        order.save
        raise order.errors.full_messages if order.errors.any?
        order
      end
    end

    def get_order(user)
      order = get_order_by_user(user)
      order.save(validate: false)
      order
    end

    def get_order_by_user(user)
      user.orders.find_or_initialize_by(status: 'inprogress')
    end

    def build_and_assign_order(order, order_detail_params)
      order_detail = order.order_details.find_by(item_id: order_detail_params[:item_id])
      if order_detail.present?
        order_detail_params[:id] = order_detail.id
        order_detail_params[:quantity] = order_detail.quantity + order_detail_params[:quantity].to_i
        order.assign_attributes(order_details_attributes: [order_detail_params])
      else
        order.order_details.build(order_detail_params)
      end
      order
    end

    def update_offer_for(order)
      item_ids = order.order_details.map(&:item_id)
      offer_by_base_itme = Offer.where(base_item_id: item_ids)
      offer_by_child_itme = Offer.where(child_item_id: item_ids)
      offers = offer_by_base_itme.or(offer_by_child_itme)
      order.offer = offers.find do |offer|
        base_order_detail = order.order_details.find { |order_detail| offer.base_item_id == order_detail.item_id }
        if base_order_detail.present?
          if base_order_detail.quantity >= offer.base_item_quantity && offer.is_discount_available
            child_order_detail = order.order_details.find { |order_detail| offer.child_item_id == order_detail.item_id }
            if child_order_detail.present? && child_order_detail.quantity >= offer.child_item_quantity
              offer
            end
          else
            offer
          end
        end
      end
    end
  end
end