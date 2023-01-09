class OffersController < ApplicationController
  skip_before_action :authenticate_user
  before_action :set_item, only: %i[ show edit update destroy ]

  # GET /items or /items.json
  def index
    @offers = Offer.includes(:base_item, :child_item, :free_item, :offer_applied_on_item_type)
    render json: { status: :success,
      offers: @offers.as_json(methods: [:base_item_name, :base_item_image_url, :child_item_name, :child_item_image_url, :offer_applied_on_item_type_name, :free_item_name, :free_item_image_url]),
      errors: [],
      message: "" 
    }, status: :ok
  end
end