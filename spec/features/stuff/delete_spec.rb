require 'rails_helper'

feature 'User can delete stuff', js: true do
  given(:other_user) { create(:user, email: 'other@mail.com') }
  given(:owner_user) { create(:user) }
  given!(:stuff) { create(:stuff, user: owner_user) }

  describe 'Authenticated user' do
    background { sign_in(owner_user) }

    scenario 'owner can delete stuff' do
      visit account_path(owner_user.account)
      within "#stuff_id_#{stuff.id}" do
        accept_alert { click_on 'delete' }
      end
      expect(page).to_not have_css "#stuff_id_#{stuff.id}"
    end
    scenario 'not owner cannot delete stuff' do
      sign_in(other_user)
      visit account_path(other_user.account)

      expect(page).to_not have_css "#stuff_id_#{stuff.id}"
    end
  end
  describe 'Guest' do
    scenario 'cannot delete stuff' do
      visit root_path
      expect(page).to_not have_selector :link_or_button, 'account'
    end
  end
end
