class SinglySalesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:kites]

  authorize_resource class: Ad

  def kites
    @kites = Kite.where(singly_sale: true)
  end
end
