class OrdersController < ApplicationController
  before_action :set_order, only: %i[ current_order update ]

  # GET /current_order.json
  def current_order
    render json: { status: :success,
      order: @order.as_json(include: [:offer, order_details: {methods: [:item_image_url, :item_name]}]),
      errors: [],
      message: "" 
    }, status: :ok
  end

  # # PATCH/PUT /orders/1.json
  # def update
  #   if @order.update(order_params)
  #     render json: { status: :success,
  #       order: @order.as_json(include: :order_details),
  #       errors: [],
  #       message: "Order was successfully Update" 
  #     }, status: :ok
  #   else
  #     render json: { status: :success,
  #       order: @order.as_json(include: :order_details),
  #       errors: @order.errors.messages,
  #       message: "Order was Failed to Update" 
  #     }, status: :unprocessable_entity
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = current_user.orders.inprogress.first
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(
        "status",
        order_details_attributes: ["item_id", "amount", "total_tax", "_destroy", "id", "quantity"])
    end
end