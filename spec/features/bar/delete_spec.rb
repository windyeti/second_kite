require 'rails_helper'

feature 'User can delete bar', js: true do
  describe 'Authenticated user' do
    given(:other_user) { create(:user, email: 'other@mail.com') }
    given(:owner_user) { create(:user) }
    given!(:bar) { create(:bar, user: owner_user) }

    scenario 'owner can delete bar' do
      sign_in(owner_user)
      visit account_path(owner_user.account)
      within "#bar_id_#{bar.id}" do
        accept_alert { click_on 'delete' }
      end

      expect(page).to_not have_css "#bar_id_#{bar.id}"
    end

    scenario 'not owner can not delete bar' do
      sign_in(other_user)
      visit account_path(owner_user.account)

      expect(page).to_not have_css "#bar_id_#{bar.id}"
    end
  end

  describe 'Guest' do
    scenario 'can not delete bar' do
      visit root_path
      expect(page).to_not have_selector :link_or_button, 'account'
    end
  end
end
