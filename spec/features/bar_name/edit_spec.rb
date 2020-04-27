require 'rails_helper'

feature 'Admin can edit bar_name' do
  describe 'Admin' do
    given(:brand) { create(:brand, name: 'Airush') }
    given!(:bar_name) { create(:bar_name, name: 'ProBar', brand: brand) }
    given(:admin_user) { create(:user, role: 'Admin') }
    background { sign_in(admin_user) }

    scenario 'can edit bar_name with valid data' do
      visit root_path
      click_on 'Brands'

      within '.brand_name' do
        click_on brand.name
      end

      within '.bar-name__item' do
        click_on 'edit'
      end

      fill_in 'bar_name_name', with: 'NewNameBar'
      click_on 'Update Bar name'

      expect(page).to have_content 'NewNameBar'
    end
    scenario 'can not edit bar_name with invalid data' do
      visit root_path
      click_on 'Brands'

      within '.brand_name' do
        click_on brand.name
      end

      within '.bar-name__item' do
        click_on 'edit'
      end

      fill_in 'bar_name_name', with: ''
      click_on 'Update Bar name'

      expect(page).to have_content "Edit Bar_name (Model)"
      expect(page).to_not have_content 'NewNameBar'
    end
  end
  describe 'Authenticated user not admin' do
    scenario 'can not edit bar_name' do
      visit root_path
      expect(page).to_not have_selector :link_or_button, 'account'
    end
  end
  describe 'Guest' do
    scenario 'can not edit bar_name' do
      visit root_path
      expect(page).to_not have_selector :link_or_button, 'account'
    end
  end
end
