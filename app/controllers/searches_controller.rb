class SearchesController < ApplicationController
  skip_before_action :authenticate_user!
  skip_authorization_check

  def index
    @ads = Services::Search.call(search_params)
    redirect_to root_path unless @ads
  end

  private

  def search_params
    params.permit(:scope, :query)
  end
end
