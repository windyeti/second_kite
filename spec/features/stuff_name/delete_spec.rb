require 'rails_helper'

feature 'Admin can delete stuff_name', js: true do
  given(:brand) { create(:brand) }
  given!(:stuff_name) { create(:stuff_name, brand: brand) }

  describe 'Admin' do
    given(:admin_user) { create(:user, role: 'Admin') }
    background { sign_in(admin_user) }

    scenario 'can delete' do
      visit brands_path
      click_on brand.name
      within "#stuff_name_id_#{stuff_name.id}" do
        accept_alert { click_on 'delete' }
      end
      expect(page).to_not have_css "#stuff_name_id_#{stuff_name.id}"
    end
  end
  describe 'Authenticated user not admin' do
    scenario 'cannot delete stuff_name' do
      visit root_path
      expect(page).to_not have_selector :link_or_button, 'Brands'
    end
  end
  describe 'Guest' do
    scenario 'cannot delete stuff_name' do
      visit root_path
      expect(page).to_not have_selector :link_or_button, 'Brands'
    end
  end
end
