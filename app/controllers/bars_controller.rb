class BarsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :load_bar, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def new
    @bar = Bar.new
  end

  def create
    return render json: { errors: ['Brand and Madel can\'t be blank'] }, status: 422 if bar_params[:brand].empty? || bar_params[:madel].empty?
    @bar = Bar.custom_create(bar_params, current_user)

    respond_to do |format|
      if @bar.valid?
        format.json { render json:
                       {
                         equipment: {
                           bar: @bar,
                           bar_name: @bar.bar_name.name,
                           approve_madel: @bar.bar_name.approve }
                       }
        }
      else
        format.json { render json: { errors: @bar.errors.full_messages }, status: 422 }
      end
    end
  end

  def show; end

  def edit; end

  def update
    return render json: { errors: ['Brand and Madel can\'t be blank'] }, status: 422 if bar_params[:brand].empty? || bar_params[:madel].empty?
    @bar.custom_update(bar_params)

    respond_to do |format|
      if @bar.valid?
        format.json { render json:
                               {
                                 equipment: {
                                   bar: @bar,
                                   bar_name: @bar.bar_name.name,
                                   approve_madel: @bar.bar_name.approve }
                               }
        }
      else
        format.json { render json: { errors: @bar.errors.full_messages }, status: 422 }
      end
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
    params.require(:bar).permit(:brand,
                                :madel,
                                :length,
                                :year,
                                :quality,
                                :price,
                                :singly_sale,
                                best_photos: [],
                                trouble_photos: [])
  end
end
