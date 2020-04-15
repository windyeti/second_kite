require 'rails_helper'

feature 'Admin can create brand' do
  context 'Admin' do
    given(:admin_user) { create(:user, role: 'Admin') }
    background { sign_in(admin_user) }

    scenario 'can create with valid data' do
      visit root_path
      within '.admin_panel' do
        click_on 'Brands'
      end

      click_on 'Add brand'

      fill_in 'Name', with: 'F-One'

      click_on 'Create Brand'

      within 'h4' do
        expect(page).to have_content 'F-One'
      end
    end

    scenario 'can not create with invalid data' do
      visit root_path
      within '.admin_panel' do
        click_on 'Brands'
      end

      click_on 'Add brand'

      fill_in 'Name', with: ''

      click_on 'Create Brand'

      within 'h1' do
        expect(page).to have_content 'New brand'
      end
    end
  end
  context 'Authenticated user' do
    scenario 'can not create with invalid data' do
      visit root_path

      expect(page).to_not have_selector(:link_or_button, 'Add brand')
    end
  end
  context 'Guest' do
    scenario 'can not create with invalid data' do
      visit root_path

      expect(page).to_not have_selector(:link_or_button, 'Add brand')
    end
  end
end
