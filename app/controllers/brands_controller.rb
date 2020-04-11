class BrandsController < ApplicationController
  authorize_resource

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.create(brand_params)
    if @brand.save
      redirect_to @brand
    else
      render :new
    end
  end

  def show
    @brand = Brand.find(params[:id])
  end

  private

  def brand_params
    params[:brand][:type_equipment_ids].reject!(&:blank?)
    params.require(:brand).permit(:name, :type_equipment_ids => [])
  end
end
