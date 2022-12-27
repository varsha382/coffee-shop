class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show edit update destroy ]

  # GET /items or /items.json
  def index
    @items = ItemType.includes(:items)

    render json: { status: :success,
      item_type: @items.as_json(only: [:name], include: { items: {only: [:id, :name, :amount], methods: [:image_url]} }),
      errors: [],
      message: "" 
    }, status: :ok
  end

  # GET /items/1 or /items/1.json
  def show
    render json: { status: :success,
      item_type: @item.as_json(only: [:id, :name, :amount, :rate ], methods: :rate),
      errors: [],
      message: "" 
    }, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end
end