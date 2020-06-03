require 'rails_helper'

feature 'Admin can delete bar_name', js: true do
  given(:brand) { create(:brand, name: 'Airush') }
  given!(:bar_name) { create(:bar_name, name: 'ProBar', brand: brand) }

  describe 'Admin' do
    given(:admin_user) { create(:user, role: 'Admin') }
    background { sign_in(admin_user) }

    scenario 'can delete bar_name' do
      visit root_path
      click_on 'Brands'

      click_on brand.name

      within "#bar_name_id_#{bar_name.id}" do
        accept_alert { click_on 'delete' }
      end

      expect(page).to_not have_content 'ProBar'
      expect(page).to_not have_css "#bar_name_id_#{bar_name.id}"
    end
  end

  describe 'Authenticated user not admin' do
    given(:user) { create(:user) }
    background { sign_in(user) }

    scenario 'can not delete bar_name' do
      visit root_path
      expect(page).to_not have_selector :link_or_button, 'Brands'
    end
  end
  describe 'Guest' do
    scenario 'can not delete bar_name' do
      visit root_path
      expect(page).to_not have_selector :link_or_button, 'Brands'
    end
  end
end
