class BarsController < ApplicationController
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

  def show
    @bar = Bar.find(params[:id])
  end

  private

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
