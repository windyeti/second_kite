class KiteNamesController < ApplicationController
  before_action :load_brand, only: [:index, :create]
  before_action :load_kite_name, only: [:show, :edit, :update, :destroy]

  authorize_resource

  def index
    @kite_name = KiteName.new
  end

  def create
    @kite_name = @brand.kite_names.new(kite_name_params)
    respond_to do |format|
      if @kite_name.save
        format.json { render json: { kite_name: @kite_name, approve: @kite_name.approve } }
      else
        format.json { render json: { errors: @kite_name.errors.full_messages }, status: 422 }
      end
    end
  end

  def show; end

  def edit; end

  def update
    if @kite_name.update(kite_name_params)
      redirect_to @kite_name
    else
      render :edit
    end
  end

  def destroy
    @kite_name.destroy
  end

  private

  def kite_name_params
    params.require(:kite_name).permit(:name, :approve)
  end

  def load_brand
    @brand = Brand.find(params[:brand_id])
  end

  def load_kite_name
    @kite_name = KiteName.find(params[:id])
  end
end
