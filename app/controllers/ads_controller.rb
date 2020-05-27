class AdsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :load_ad, only: [:show, :edit, :update, :destroy]

  authorize_resource

  def index
    @ads = Ad.where(approve: true)
  end

  def new
    @ad = Ad.new
  end

  def create
    @ad = current_user.ads.new(ad_params)
    @ad.approve = Ad.approve?(ad_params)
    if @ad.save
      redirect_to @ad, notice: 'You created ad'
    else
      flash.now[:alert] = 'Ad does not create. Something went wrong'
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    @ad.approve = Ad.approve?(ad_params)
    if @ad.update(ad_params)
      redirect_to @ad, notice: "Ad #{@ad.title} updated"
    else
      flash.now[:alert] = 'Something went wrong'
      render :edit
    end
  end

  def destroy
    @ad.destroy
    redirect_to ads_path
  end

  private

  def ad_params
    params.require(:ad).permit(:title,
                               :description,
                               :total_price,
                               kite_ids: [],
                               board_ids: [],
                               bar_ids: [],
                               stuff_ids: [])
  end

  def load_ad
    @ad = Ad.find(params[:id])
  end
end
