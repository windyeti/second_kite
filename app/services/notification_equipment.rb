class Services::NotificationEquipment
  def call(ad)
    kite_name_subscriptions(ad)
    board_name_subscriptions(ad)
    bar_name_subscriptions(ad)
    stuff_name_subscriptions(ad)
  end

  private

  def kite_name_subscriptions(ad)
    ad.kites.each do |k|
      subscriptions = Subscription.where(subscriptionable: k.kite_name)
      subscriptions.find_each do |subscription|
        SubscriptionMailer.notify(subscription).deliver_later
      end
    end
  end

  def board_name_subscriptions(ad)
    ad.boards.each do |b|
      subscriptions = Subscription.where(subscriptionable: b.board_name)
      subscriptions.find_each do |subscription|
        SubscriptionMailer.notify(subscription).deliver_later
      end
    end
  end

  def bar_name_subscriptions(ad)
    ad.bars.each do |b|
      subscriptions = Subscription.where(subscriptionable: b.bar_name)
      subscriptions.find_each do |subscription|
        SubscriptionMailer.notify(subscription).deliver_later
      end
    end
  end

  def stuff_name_subscriptions(ad)
    ad.stuffs.each do |s|
      subscriptions = Subscription.where(subscriptionable: s.stuff_name)
      subscriptions.find_each do |subscription|
        SubscriptionMailer.notify(subscription).deliver_later
      end
    end
  end
end
