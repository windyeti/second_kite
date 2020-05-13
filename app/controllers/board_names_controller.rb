class BoardNamesController < ApplicationController
  before_action :load_board_name, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def create
    @brand = Brand.find(params[:brand_id])
    @board_name = @brand.board_names.new(board_name_params)
    respond_to do |format|
      if @board_name.save
        format.json { render json: { board_name: @board_name } }
      else
        format.json { render json: { errors: @board_name.errors.full_messages }, status: 422 }
      end
    end
  end

  def edit; end

  def update
    if @board_name.update(board_name_params)
      redirect_to @board_name
    else
      render :edit
    end
  end

  def show; end

  def destroy
    @board_name.destroy
  end

  private

  def board_name_params
    params.require(:board_name).permit(:name)
  end

  def load_board_name
    @board_name = BoardName.find(params[:id])
  end
end
