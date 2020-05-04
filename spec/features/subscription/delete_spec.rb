require 'rails_helper'


feature 'User can delete subscription', js: true do
  describe 'Authenticated user' do
    given(:user) { create(:user) }
    given(:brand) { create(:brand) }
    given(:kite_name) { create(:kite_name, brand: brand) }
    given!(:subscription) { create(:subscription, subscriptionable: kite_name, user: user) }

    background { sign_in(user) }

    scenario 'can subscription for model of kite' do
      visit account_path(user.account)
      within "#subscription_id_#{subscription.id}" do
        accept_alert { click_on 'unsubscription' }
      end

      within '.subscriptions' do
        expect(page).to_not have_css "#subscription_id_#{subscription.id}"
      end
    end
  end

  describe 'Guest' do
    scenario 'cannot delete subscription' do
      visit root_path
      expect(page).to_not have_selector :link_or_button, 'account'
    end
  end

end
