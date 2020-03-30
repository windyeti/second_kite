class AdsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :load_ad, only: [:show]
  authorize_resource

  def index
    @ads = Ad.all
  end

  def new
    @ad = Ad.new
  end

  def create
    @ad = current_user.ads.new(ad_params)
    if @ad.save
      redirect_to @ad, status: 302, notice: 'You created ad'
    else
      flash.now[:alert] = 'Ad does not create. Something went wrong'
      render :new
    end
  end

  def show; end

  private

  def ad_params
    params.require(:ad).permit(:title, :description, :total_price)
  end

  def load_ad
    @ad = Ad.find(params[:id])
  end
end
