class AccountsController < ApplicationController
  before_action :load_account, only: [:show]

  authorize_resource

  def show; end

  private

  def load_account
    @account = Account.find(params[:id])
  end
end
