require 'rails_helper'

feature 'Admin can create kite_name' do
  context 'Admin' do
    given!(:brand) { create(:brand, name: 'Ozone') }
    given(:admin_user) { create(:user, role: 'Admin') }
    background { sign_in(admin_user) }

    scenario 'with valid data can create' do
      visit root_path
      within '.admin_panel' do
        click_on 'Brands'
      end

      within '.brand_name' do
        click_on brand.name
      end

      fill_in 'Name', with: 'Edge'
      click_on 'Create Kite name'

      within '.kite-name__list' do
        expect(page).to have_selector(:link_or_button, 'Edge')
      end
    end
    scenario 'with invalid data can not create' do
      visit root_path
      within '.admin_panel' do
        click_on 'Brands'
      end

      within '.brand_name' do
        click_on brand.name
      end

      fill_in 'Name', with: ''
      click_on 'Create Kite name'

      within '.kite-name__list' do
        expect(page).to_not have_selector(:link_or_button, 'Edge')
      end
    end
  end
  context 'Authenticated user not admin' do
    scenario 'can not create' do
      visit root_path
      expect(page).to_not have_css '.admin_panel'
    end
  end
  context 'Guest' do
    scenario 'can not create' do
      visit root_path
      expect(page).to_not have_css '.admin_panel'
    end
  end
end
