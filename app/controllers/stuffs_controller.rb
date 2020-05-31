class StuffsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :load_stuff, only: [:show, :edit, :update, :destroy]

  authorize_resource

  def new
    @stuff = Stuff.new
  end

  def create
    return render json: { errors: ['Brand and Madel can\'t be blank'] }, status: 422 if stuff_params[:brand].empty? || stuff_params[:madel].empty?
    @stuff = Stuff.custom_create(stuff_params, current_user)

    respond_to do |format|
      if @stuff.valid?
        format.json { render json:
                               {
                                 equipment: {
                                   stuff: @stuff,
                                   stuff_name: @stuff.stuff_name.name,
                                   approve_madel: @stuff.stuff_name.approve }
                               }
        }
      else
        format.json { render json: { errors: @stuff.errors.full_messages }, status: 422 }
      end
    end
  end

  def show; end

  def edit; end

  def update
    return render json: { errors: ['Brand and Madel can\'t be blank'] }, status: 422 if stuff_params[:brand].empty? || stuff_params[:madel].empty?
    @stuff.custom_update(stuff_params)

    respond_to do |format|
      if @stuff.valid?
        format.json { render json:
                               {
                                 equipment: {
                                   stuff: @stuff,
                                   stuff_name: @stuff.stuff_name.name,
                                   approve_madel: @stuff.stuff_name.approve }
                               }
        }
      else
        format.json { render json: { errors: @stuff.errors.full_messages }, status: 422 }
      end
    end
  end

  def destroy
    @stuff.destroy
  end

  private

  def load_stuff
    @stuff = Stuff.find(params[:id])
  end

  def stuff_params
    params.require(:stuff).permit(:brand,
                                  :madel,
                                  :price,
                                  :quality,
                                  :year,
                                  :description,
                                  :singly_sale,
                                  best_photos: [],
                                  trouble_photos: [])
  end
end
