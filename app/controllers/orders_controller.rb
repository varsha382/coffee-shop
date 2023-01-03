class OrdersController < ApplicationController
  skip_before_action :authenticate_user
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders/1.json
  def show
    render json: { status: :success,
      order: @order.as_json(include: :order_details, :offer),
      errors: [],
      message: "" 
    }, status: :ok
  end

  # POST /orders.json
  def create
    @order = Order.new(order_params)

    if @order.save
      render json: { status: :success,
        order: @order.as_json(include: :order_details),
        errors: [],
        message: "Order was successfully Created" 
      }, status: :ok
    else
      render json: { status: :success,
        order: @order.as_json(include: :order_details),
        errors: @order.errors.messages,
        message: "Order was Failed to Create" 
      }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/1.json
  def update
    if @order.update(order_params)
      render json: { status: :success,
        order: @order.as_json(include: :order_details),
        errors: [],
        message: "Order was successfully Update" 
      }, status: :ok
    else
      render json: { status: :success,
        order: @order.as_json(include: :order_details),
        errors: @order.errors.messages,
        message: "Order was Failed to Update" 
      }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = current_user.orders.inprogress.first
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(
        "customer_name",                           
        "customer_email",
        "status",
        "amount",
        "total_tax",
        "total_amount",
        # "is_discount_available",
        # "discount_amount",
        # "offer_id",
        # "free_items",
        order_details_attributes: ["item_id", "amount", "total_tax", "_destroy", "id", "quantity"])
    end
end