class KitesController < ApplicationController
  before_action :load_kite_name, only: [:new, :create]
  before_action :load_kite, only: [:show, :edit, :update, :destroy]

  authorize_resource

  def new
    @kite = Kite.new
  end

  def create
    @kite = @kite_name.kites.new(kite_params)
    @kite.user = current_user

    if @kite.save
      redirect_to @kite
    else
      render :new
    end
  end

  def show
    authorize! :show, @kite
  end

  def edit
    authorize! :edit, @kite
  end

  def update
    if @kite.update(kite_params)
      redirect_to @kite
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, @kite

    @kite.destroy
  end

  private

  def kite_params
    params.require(:kite).permit(:year,
                                 :size,
                                 :price,
                                 :quality,
                                 best_photos: [],
                                 trouble_photos: []
                                )
  end

  def load_kite_name
    @kite_name = KiteName.find(params[:kite_name_id])
  end

  def load_kite
    @kite = Kite.find(params[:id])
  end
end
