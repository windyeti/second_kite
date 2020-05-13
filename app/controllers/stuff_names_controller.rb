class StuffNamesController < ApplicationController
  before_action :load_brand, only: [:create]
  before_action :load_stuff_name, only: [:edit, :update, :show, :destroy]
  authorize_resource

  def create
    @stuff_name = @brand.stuff_names.new(stuff_name_params)
    respond_to do |format|
      if @stuff_name.save
        format.json { render json: { stuff_name: @stuff_name } }
      else
        format.json { render json: { errors: @stuff_name.errors.full_messages }, status: 422 }
      end
    end
  end

  def edit; end

  def update
    if @stuff_name.update(stuff_name_params)
      redirect_to @stuff_name
    else
      render :edit
    end
  end

  def show; end

  def destroy
    @stuff_name.destroy
  end

  private

  def stuff_name_params
    params.require(:stuff_name).permit(:name)
  end

  def load_brand
    @brand = Brand.find(params[:brand_id])
  end

  def load_stuff_name
    @stuff_name = StuffName.find(params[:id])
  end
end
