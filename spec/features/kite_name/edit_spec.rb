require 'rails_helper'

feature 'Admin cat edit kite type' do
  given!(:brand) { create(:brand, name: 'F-One') }
  given!(:kite_name) { create(:kite_name, name: 'Bandit', brand: brand) }

  context 'Admin' do
    given(:admin_user) { create(:user, role: 'Admin') }
    background { sign_in(admin_user) }
    scenario 'with valid data can edit kite name' do
      visit root_path
      within '.admin_panel' do
        click_on 'Brands'
      end

      click_on brand.name

      within '.kite-name__item' do
        click_on 'edit'
      end

      fill_in 'Name', with: 'Master'
      click_on 'Update Kite name'

      within '.kite-name' do
        expect(page).to have_content'Master'
      end
    end
    scenario 'with invalid data can not edit kite name' do
      visit root_path
      within '.admin_panel' do
        click_on 'Brands'
      end

      click_on brand.name

      within '.kite-name__item' do
        click_on 'edit'
      end

      fill_in 'Name', with: ''
      click_on 'Update Kite name'

      expect(page).to have_content'Edit Kite name'
    end
  end
  context 'Authenticated user not admin' do
    given(:user) { create(:user) }
    background { sign_in(user) }

    scenario 'can not update kite name' do
      visit root_path
      expect(page).to_not have_css('.admin_panel')
    end
  end
  context 'Guest' do
    scenario 'can not update kite name' do
      visit root_path
      expect(page).to_not have_css('.admin_panel')
    end
  end
end
