class AccountsController < ApplicationController
  authorize_resource

  def show
    @account = Account.find(params[:id])
  end
end
