class BoardsController < ApplicationController
  before_action :load_board_name, only: [:new, :create]
  before_action :load_board, only: [:show, :edit, :update]
  authorize_resource

  def new
    @board = Board.new
  end

  def create
    @board_name = BoardName.find(params[:board_name_id])
    @board = @board_name.boards.new(board_params)
    @board.user = current_user

    if @board.save
      redirect_to @board
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @board.update(board_params)
      redirect_to @board
    else
      render :edit
    end
  end

  private

  def load_board_name
    @board_name = BoardName.find(params[:board_name_id])
  end

  def load_board
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(
                                  :length,
                                  :width,
                                  :pads,
                                  :fins,
                                  :singly_sale,
                                  :year,
                                  :quality,
                                  :price,
                                  best_photos: [],
                                  trouble_photos: []
                                  )
  end
end
