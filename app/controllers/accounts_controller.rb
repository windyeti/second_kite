class AccountsController < ApplicationController
  before_action :load_account, only: [:show, :edit, :update]

  authorize_resource

  def show; end

  def edit; end

  def update
    @account.update(account_params)
    redirect_to @account
  end

  private

  def load_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:nickname, :phone, :city)
  end
end
