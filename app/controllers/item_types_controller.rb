class ItemTypesController < ApplicationController
  before_action :set_item, only: %i[ show edit update destroy ]

  # GET /item_types or /item_types.json
  def index
    @item_types = ItemType.includes(:tax_rate)
  end

  # GET /item_types/1 or /item_types/1.json
  def show
    render json: { status: :success, item_type: @item_type.as_json, errors: [], message: "" }, status: :ok
  end

  # POST /item_types or /item_types.json
  def create
    @item_type = ItemType.new(item_params)

    if @item_type.save
      render json: { status: :success, item_type: @item_type.as_json, errors: [], message: "Item types was successfully created." }, status: :ok
    else
      render json: { status: :failed, item_type: @item_type.as_json, errors: [], message: "Item types was successfully created." }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /item_types/1 or /item_types/1.json
  def update

    if @item_type.save
      render json: { status: :success, item_type: @item_type.as_json, errors: [], message: "Item types was successfully updated." }, status: :ok
    else
      render json: { status: :failed, item_type: @item_type.as_json, errors: [], message: "" }, status: :unprocessable_entity
    end
    respond_to do |format|
      if @item_type.update(item_params)
        format.html { redirect_to item_url(@item), notice: "Item types was successfully updated." }
        format.json { render :show, status: :ok, location: @item_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_types/1 or /item_types/1.json
  def destroy
    @item_type.destroy

    respond_to do |format|
      format.html { redirect_to item_types_url, notice: "Item types was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item_types = ItemType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item_type).permit(:name)
    end
end