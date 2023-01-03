class OrderDetailsController < ApplicationController
  before_action :set_order_detail, only: %i[ show edit update destroy ]

  # POST /order_details.json
  def create
    response = CreateAndUpdateOrderItem.call(current_user, order_detail_params)

    if response[:status] == :success
      render json: response, status: :ok
    else
      render json: response, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_detail
      @order = OrderDetail.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_detail_params
      params.require(:order_detail).permit("item_id", "quantity", "id", "_destroy")
    end
end