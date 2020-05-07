class SubscriptionMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.subscription_mailer.notify.subject
  #
  def notify(subscription)
    @greeting = "Hi"
    @user = subscription.user
    @model_equipment = subscription.subscriptionable.name

    mail to: @user.email
  end
end
