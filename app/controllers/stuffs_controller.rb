class StuffsController < ApplicationController
  before_action :load_stuff, only: [:show, :edit, :update, :destroy]

  authorize_resource

  def new
    @stuff_name = StuffName.find(params[:stuff_name_id])
    @stuff = @stuff_name.stuffs.new
  end

  def create
    @stuff_name = StuffName.find(params[:stuff_name_id])
    @stuff = @stuff_name.stuffs.new(stuff_params)
    @stuff.user = current_user
    if @stuff.save
      redirect_to @stuff
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @stuff.update(stuff_params)
      redirect_to @stuff
    else
      render :edit
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
    params.require(:stuff).permit(:price,
                                  :quality,
                                  :year,
                                  :description,
                                  :singly_sale,
                                  best_photos: [],
                                  trouble_photos: [])
  end
end
