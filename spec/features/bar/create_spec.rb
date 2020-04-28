require 'rails_helper'

feature 'User create bar',
  %q{ User create a bar that can
be added to the ad for sale } do
  describe 'Authenticated user' do
    given(:brand) { create(:brand, name: 'Airush') }
    given(:bar_name) { create(:bar_name, name: 'One-Two-size', brand: brand) }
    given(:owner_user) { create(:user) }
    background { sign_in(owner_user) }

    scenario 'can create bar with valid data' do
      visit account_path(owner_user.account)
      click_on 'Add bar'

      #   ///////////////////
      #       fill field
      #   ///////////////////

      click_on 'Create Bar'

      expect(page).to have_content LENGTH_NEW_BAR
    end
    scenario 'can not create bar with invalid data' do

    end
  end

  describe 'Guest' do
    scenario 'can not create bar' do
      visit root_path
      expect(page).to_not have_selector :link_or_button, 'account'
    end
  end
end
