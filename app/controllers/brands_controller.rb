class BrandsController < ApplicationController
  authorize_resource

  def new
    @brand = Brand.new
  end
end
