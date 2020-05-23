class KitesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :load_kite, only: [:show, :edit, :update, :destroy]

  authorize_resource

  def new
    @kite = Kite.new
  end

  def create
    return render json: { errors: ['Brand and Madel can\'t be blank'] }, status: 422 if kite_params[:brand].empty? || kite_params[:madel].empty?
    params = custom_params
    @kite = current_user.kites.new(params)

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
    return render json: { errors: ['Brand and Madel can\'t be blank'] }, status: 422 if kite_params[:brand].empty? || kite_params[:madel].empty?
    params = custom_params

    respond_to do |format|
      if @kite.update(params)
        format.json { render json: { equipment: { kite: @kite, kite_name: @kite.kite_name.name } } }
      else
        format.json { render json: { errors: @kite.errors.full_messages }, status: 422 }
      end
    end
  end

  def destroy
    authorize! :destroy, @kite

    @kite.destroy
  end

  private

  def kite_params
    params.require(:kite).permit(:brand,
                                 :madel,
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

  def custom_params
    kite_name = KiteName.find_kite_name(kite_params)

    new_params = kite_params
    new_params.delete(:brand)
    new_params.delete(:madel)
    new_params[:kite_name] = kite_name
    new_params
  end
end
