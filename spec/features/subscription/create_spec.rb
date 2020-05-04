require 'rails_helper'

feature 'User can subscription for model of equipment' do
  describe 'Authenticated user' do
    given(:user) { create(:user) }
    given!(:brand) { create(:brand) }
    given!(:kite_name) { create(:kite_name, brand: brand) }
    background { sign_in(user) }

    scenario 'can subscription for model of kite' do
      visit account_path(user.account)

      click_on 'Add kite'
      click_on brand.name

      within "#kite_name_id_#{kite_name.id}" do
        click_on 'subscription'
      end

      visit account_path(user.account)

      within '.subscriptions' do
        expect(page).to have_content kite_name.name
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
