class DismissUserBrandJob < ApplicationJob
  queue_as :default

  def perform(args)
    Services::NotificationDismiss.new.call(args)
  end
end
