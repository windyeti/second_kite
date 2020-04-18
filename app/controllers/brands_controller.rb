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
    @kite_name = @brand.kite_names.new
  end

  def index
    @brands = Brand.all
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
