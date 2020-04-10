require 'rails_helper'

feature 'Admin can create type equipment' do
  context 'Admin' do
    given(:admin_user) { create(:user, role: 'Admin') }
    background { sign_in(admin_user) }

    scenario 'can create with valid data' do
      visit root_path
      within '.admin_panel' do
        click_on 'Add type equipment'
      end

      fill_in 'Name', with: 'kite'

      click_on 'Create Type equipment'

      expect(page).to have_content 'kite'
    end

    scenario 'can not create with invalid data' do
      visit root_path
      within '.admin_panel' do
        click_on 'Add type equipment'
      end

      fill_in 'Name', with: ''

      click_on 'Create Type equipment'

      expect(page).to have_content 'New type equipment'
    end
  end
  context 'Authenticated user not admin' do
    given(:user) { create(:user) }
    background { sign_in(user) }

    scenario 'can not create with invalid data' do
      visit root_path

      expect(page).to_not have_selector(:link_or_button, 'Add type equipment')
    end
  end
  context 'Guest' do
    scenario 'can not create with invalid data' do
      visit root_path

      expect(page).to_not have_selector(:link_or_button, 'Add type equipment')
    end
  end
end
