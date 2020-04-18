class KitesController < ApplicationController
  before_action :load_kite_name, only: [:new, :create]

  authorize_resource

  def new
    @kite = Kite.new
  end

  def create
    @kite = @kite_name.kites.create(kite_params)
    @kite.user = current_user

    if @kite.save
      redirect_to @kite
    else
      render :new
    end
  end

  def show
    @kite = Kite.find(params[:id])
    authorize! :show, @kite
  end

  private

  def kite_params
    params.require(:kite).permit(:year, :size, :price, :quality)
  end

  def load_kite_name
    @kite_name = KiteName.find(params[:kite_name_id])
  end


  # authorize_resource
  #
  # def new
  #   @kite = Kite.new
  # end
  #
  # def create
  #   @kite = current_user.kites.new(kite_params)
  #   @kite.kite_name = @kite_name
  #
  #   if @kite.save
  #     redirect_to @kite
  #   else
  #     render :new
  #   end
  # end
  #
  # private
  #
  # def kite_params
  #   kite_name_id = params.require(:kite).permit(:kite_name)[:kite_name]
  #   @kite_name = KiteName.find_by( id: kite_name_id )
  #   params.require(:kite).permit(:year, :size, :price, :quality)
  # end
end
