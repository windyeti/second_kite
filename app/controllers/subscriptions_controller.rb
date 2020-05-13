class SubscriptionsController < ApplicationController
  before_action :subscriptionable, only: [:create]
  authorize_resource

  def create
    return unless current_user.subscribable?(@subscriptionable)
    @subscription = @subscriptionable.subscriptions.create(user: current_user)
    redirect_to current_user.account
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy
  end

  private

  def subscriptionable
    @subscriptionable = name_subscriptionable_resource
                                                      .classify
                                                      .constantize
                                                      .find(params["#{name_subscriptionable_resource.singularize}_id"])
  end

  def name_subscriptionable_resource
    params[:subscriptionable]
  end
end
