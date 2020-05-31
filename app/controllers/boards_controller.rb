class BoardsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :load_board, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def new
    @board = Board.new
  end

  def create
    return render json: { errors: ['Brand and Madel can\'t be blank'] }, status: 422 if board_params[:brand].empty? || board_params[:madel].empty?
    @board = Board.custom_create(board_params, current_user)

    respond_to do |format|
      if @board.valid?
        format.json { render json:
          {
            equipment: {
              board: @board,
              board_name: @board.board_name.name,
              approve_madel: @board.board_name.approve }
          }
        }      else
                 format.json { render json: { errors: @board.errors.full_messages }, status: 422 }
      end
    end
  end

  def show; end

  def edit; end

  def update
    return render json: { errors: ['Brand and Madel can\'t be blank'] }, status: 422 if board_params[:brand].empty? || board_params[:madel].empty?
    @board.custom_update(board_params)

    respond_to do |format|
      if @board.valid?
        format.json { render json:
          {
            equipment: {
              board: @board,
              board_name: @board.board_name.name,
              approve_madel: @board.board_name.approve }
          }
        }
      else
        format.json { render json: { errors: @board.errors.full_messages }, status: 422 }
      end
    end
  end

  def destroy
    @board.destroy
  end

  private

  def load_board_name
    @board_name = BoardName.find(params[:board_name_id])
  end

  def load_board
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:brand,
                                  :madel,
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
