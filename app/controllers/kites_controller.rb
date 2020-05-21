class KitesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :load_kite, only: [:show, :edit, :update, :destroy]

  authorize_resource

  def new
    @kite = Kite.new
  end

  def create
    return render json: { errors: ['Brand and kite_name can\'t be blank'] }, status: 422 if kite_params[:brand].empty? || kite_params[:kite_name].empty?
    new_params = Kite.redefine_kite_params(kite_params)

    @kite = Kite.new(new_params)
    @kite.user = current_user

    respond_to do |format|
      if @kite.save
        format.json { render json: { equipment: { kite: @kite, kite_name: @kite.kite_name.name } } }
      else
        format.json { render json: { errors: @kite.errors.full_messages }, status: 422 }
      end
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
    params.require(:kite).permit(:brand,
                                 :kite_name,
                                 :year,
                                 :size,
                                 :price,
                                 :quality,
                                 :singly_sale,
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
