class KitesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  authorize_resource

  def new
    @kite = Kite.new
  end

  def create
    @kite = current_user.kites.new(kite_params)
    if @kite.save
      redirect_to @kite
    else
      render :new
    end
  end

  def show
    @kite = Kite.find(params[:id])
  end

  private

  def kite_params
    params.require(:kite).permit(
                                  :brand,
                                  :name,
                                  :year,
                                  :size,
                                  :type,
                                  :sling_system,
                                  :length_slim,
                                  :one_pump,
                                  :price,
                                  :quality,
                                  :city,
                                  :cargoable,
                                  :origin_site
                                )
  end
end
