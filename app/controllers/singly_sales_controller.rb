class SinglySalesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:kites, :boards, :bars, :stuffs]

  authorize_resource class: Ad

  def kites
    @kites = Kite.where(singly_sale: true)
  end

  def boards
    @boards = Board.where(singly_sale: true)
  end

  def bars
    @bars = Bar.where(singly_sale: true)
  end

  def stuffs
    @stuffs = Stuff.where(singly_sale: true)
  end
end
