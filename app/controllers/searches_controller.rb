class SearchesController < ApplicationController
  skip_before_action :authenticate_user!
  skip_authorization_check

  def index
    @results = Services::Search.call(search_params)
    redirect_to root_path unless @results
  end

  private

  def search_params
    params.permit(:scope, :query)
  end
end
