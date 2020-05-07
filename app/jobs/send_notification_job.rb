class SendNotificationJob < ApplicationJob
  queue_as :default

  def perform(ad)
    Services::NotificationEquipment.new.call(ad)
  end
end
