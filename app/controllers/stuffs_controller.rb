class StuffsController < ApplicationController
  authorize_resource

  def new
    @stuff_name = StuffName.find(params[:stuff_name_id])
    @stuff = @stuff_name.stuffs.new
  end
end
