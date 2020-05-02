class SinglySalesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:kites, :boards, :bars, :stuffs]

  authorize_resource class: Ad

  def kites
    @kites = Kite.joins(:ad_kites).where(singly_sale: true).distinct
  end

  def boards
    @boards = Board.joins(:ad_boards).where(singly_sale: true).distinct
  end

  def bars
    @bars = Bar.joins(:ad_bars).where(singly_sale: true).distinct
  end

  def stuffs
    @stuffs = Stuff.joins(:ad_stuffs).where(singly_sale: true).distinct
  end
end
