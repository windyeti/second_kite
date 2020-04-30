class StuffNamesController < ApplicationController
  before_action :load_brand, only: [:create]
  before_action :load_stuff_name, only: [:edit, :update, :show]
  authorize_resource

  def create
    @stuff_name = @brand.stuff_names.new(stuff_name_params)
    respond_to do |format|
      if @stuff_name.save
        format.json { render json: {
          html: (render_to_string(partial: 'stuff_names/stuff_name.html.slim', locals: {stuff_name: @stuff_name}))
        } }
      else
        format.json { render json: {
          error: (render_to_string(partial: 'shared/errors.html.slim', locals: {resource: @stuff_name})) },
          status: 422
        }
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

  def show

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
