class CreateAndUpdateOrderItem
  class << self
    def call(user, order_detail_params)
      begin
        order = prosess(user, order_detail_params)
        {status: :success, order: order.as_json(include: [:offer, order_details: {methods: [:item_image_url, :item_name]}]), errors: [], message: "Added/Updated Item into Cart"}
      rescue => exception
        {status: :failed, errors: exception.message, message: "Failed to add item"}
      end
    end

    private
    def prosess(user, order_detail_params)
      ActiveRecord::Base.transaction do
        order = get_order(user)
        order = build_and_assign_order(order, order_detail_params)
        order.save
        order.destroy if order.order_details.blank?
        raise order.errors.full_messages if order.errors.any?
        reload_order(order.id)
      end
    end

    def get_order(user)
      order = get_order_by_user(user)
      order.save(validate: false)
      order
    end

    def reload_order(order_id)
      Order.find_by(id: order_id)
    end

    def get_order_by_user(user)
      user.orders.find_or_initialize_by(status: 'inprogress')
    end

    def build_and_assign_order(order, order_detail_params)
      order_detail = order.order_details.find_by(item_id: order_detail_params[:item_id])
      if order_detail.present?
        order_detail_params[:quantity] = calculate_quantity(order_detail, order_detail_params)
        order_detail_params[:id] = order_detail.id
        order.assign_attributes(order_details_attributes: [order_detail_params])
      else
        order.order_details.build(order_detail_params)
      end
      order
    end

    def calculate_quantity(order_detail, order_detail_params)
      if order_detail_params[:id].blank?
        order_detail.quantity.to_i + order_detail_params[:quantity].to_i
      else
        order_detail_params[:quantity].to_i
      end
    end
  end
end