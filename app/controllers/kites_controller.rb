class KitesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :load_kite, only: [:show, :edit, :update, :destroy]

  authorize_resource

  def new
    @kite = Kite.new
  end

  def create
    return render json: { errors: ['Brand and Madel can\'t be blank'] }, status: 422 if kite_params[:brand].empty? || kite_params[:madel].empty?
    @kite = Kite.custom_create(kite_params, current_user)

    respond_to do |format|
      if @kite.valid?
        format.json { render json: {
          equipment: {
            kite: @kite,
            kite_name: @kite.kite_name.name,
            approve_madel: @kite.kite_name.approve }
          }
        }      else
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
    @kite.custom_update(kite_params)

    respond_to do |format|
      if @kite.valid?
        format.json { render json: {
          equipment: {
            kite: @kite,
            kite_name: @kite.kite_name.name,
            approve_madel: @kite.kite_name.approve }
          }
        }
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
end
