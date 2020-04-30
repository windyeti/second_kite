require 'rails_helper'

feature 'Admin can create stuff_name', js: true do
  given!(:brand) { create(:brand) }

  describe 'Admin' do
    given(:admin_user) { create(:user, role: 'Admin') }
    background { sign_in(admin_user) }

    scenario 'can create stuff_name with valid data' do
      visit root_path
      click_on 'Brands'
      click_on brand.name

      within '.stuff_name_form' do
        fill_in 'stuff_name_name', with: 'NewStuffName'
        click_on 'Create Stuff name'
      end

      expect(page).to have_content 'NewStuffName'
    end
    scenario 'can not create stuff_name with invalid data' do
      visit root_path
      click_on 'Brands'
      click_on brand.name

      within '.stuff_name_form' do
        fill_in 'stuff_name_name', with: ''
        click_on 'Create Stuff name'
      end

      expect(page).to have_content 'Name can\'t be blank'
      expect(page).to have_content 'New Stuff_name'
    end
  end
  describe 'Authenticated user not admin' do
    given(:user) { create(:user) }
    background { sign_in(user) }

    scenario 'cannot create stuff_name' do
      visit root_path
      expect(page).to_not have_selector :link_or_button, 'Brands'
    end
  end
  describe 'Guest' do
    scenario 'cannot create stuff_name' do
      visit root_path
      expect(page).to_not have_selector :link_or_button, 'Brands'
    end
  end
end
