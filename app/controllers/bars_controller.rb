class BarsController < ApplicationController
  before_action :load_bar, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def new
    @bar_name = BarName.find(params[:bar_name_id])
    @bar = Bar.new
  end

  def create
    @bar_name = BarName.find(params[:bar_name_id])
    @bar = @bar_name.bars.new(bar_params)
    @bar.user = current_user
    if @bar.save
      redirect_to @bar
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @bar.update(bar_params)
      redirect_to @bar
    else
      render :edit
    end
  end

  def destroy
    @bar.destroy
  end

  private

  def load_bar
    @bar = Bar.find(params[:id])
  end

  def bar_params
    params.require(:bar).permit(:length,
                                :year,
                                :quality,
                                :price,
                                :singly_sale,
                                best_photos: [],
                                trouble_photos: [])
  end
end
