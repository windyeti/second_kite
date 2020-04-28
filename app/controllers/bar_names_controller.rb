class BarNamesController < ApplicationController
  before_action :load_bar_name, only: [:edit, :update, :show, :destroy]

  authorize_resource

  def create
    @brand = Brand.find(params[:brand_id])
    @bar_name = @brand.bar_names.new(bar_params)

    respond_to do |format|

      if @bar_name.save
        format.json { render json: {
          html: (render_to_string partial: 'bar_names/bar_name.html.slim', locals: {bar_name: @bar_name})
        } }
      else
        format.json { render json: {
          error: (render_to_string partial: 'shared/errors.html.slim', locals: {resource: @bar_name}) },
          status: 422
        }
      end
    end
  end

  def edit; end

  def update
    if @bar_name.update(bar_params)
      redirect_to @bar_name
    else
      render :edit
    end
  end

  def show; end

  def destroy
    @bar_name.destroy
  end

  private

  def bar_params
    params.require(:bar_name).permit(:name)
  end

  def load_bar_name
    @bar_name = BarName.find(params[:id])
  end
end
