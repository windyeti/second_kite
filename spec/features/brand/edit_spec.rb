require 'rails_helper'

feature 'Admin can edit brand' do
  context 'Admin' do
    given!(:brand) { create(:brand, name: 'Gaastra') }
    given(:admin_user) { create(:user, role: 'Admin') }
    background { sign_in(admin_user) }

    scenario 'with valid data can edit brand' do
      visit root_path
      click_on 'Brands'

      expect(page).to have_content 'Gaastra'

      within '.link-edit' do
        click_on 'edit'
      end

      fill_in 'Name', with: 'GA'
      click_on 'Update Brand'

      expect(page).to have_content 'GA'

    end
    scenario 'with invalid data can not edit brand' do
      visit root_path
      click_on 'Brands'

      expect(page).to have_content 'Gaastra'

      within '.link-edit' do
        click_on 'edit'
      end

      fill_in 'Name', with: ''
      click_on 'Update Brand'

      expect(page).to have_content 'Edit brand'
    end
  end
  context 'Authenticated user not admin' do
    scenario 'can not edit brand' do
      visit root_path

      expect(page).to_not have_selector(:link_or_button, 'Brands')
    end
  end
  context 'Guest' do
    scenario 'can not edit brand' do
      visit root_path

      expect(page).to_not have_selector(:link_or_button, 'Brands')
    end
  end
end
