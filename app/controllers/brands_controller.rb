class BrandsController < ApplicationController
  before_action :load_brand, only: [:show, :edit, :update, :destroy]

  authorize_resource

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)
    if @brand.save
      redirect_to @brand
    else
      render :new
    end
  end

  def show
    @kite_name = KiteName.new
    @board_name = BoardName.new
    @bar_name = BarName.new
    @stuff_name = StuffName.new
    @type_equipment = params["model_for"] unless params["model_for"].nil?
  end

  def index
    if params["brands_for"].nil?
      @brands = Brand.all
    else
      name_model_for_join = params["brands_for"].to_sym
      @brands = Brand.joins(name_model_for_join).distinct
      @type_equipment = params["brands_for"]
    end
  end

  def edit; end

  def update
    if @brand.update(brand_params)
      redirect_to @brand
    else
      render :edit
    end
  end

  def destroy
    @brand.destroy
    redirect_to brands_path
  end

  private

  def load_brand
    @brand = Brand.find(params[:id])
  end

  def brand_params
    params.require(:brand).permit(:name)
  end
end
