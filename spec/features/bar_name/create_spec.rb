require 'rails_helper'

feature 'Admin create bar_name', js: true do
  given!(:brand) { create(:brand, name: 'Airush') }

  describe 'Admin' do
    given(:admin_user) { create(:user, role: 'Admin') }
    background { sign_in(admin_user) }

    scenario 'can create bar_name with valid data' do
      visit root_path
      click_on 'Brands'

      within '.brand_name' do
        click_on brand.name
      end

      fill_in 'bar_name_name', with: 'DNA'
      click_on 'Create Bar name'

      within '.bar-name__list' do
        expect(page).to have_content 'DNA'
        # expect(page).to have_selector(:link_or_button, 'DNA')
      end
    end
    scenario 'can not create bar_name with invalid data' do
      visit root_path
      click_on 'Brands'

      within '.brand_name' do
        click_on brand.name
      end

      fill_in 'bar_name_name', with: ''
      click_on 'Create Bar name'

      within '.bar-name__errors' do
        expect(page).to have_content 'Name can\'t be blank'
      end
    end
  end
  describe 'Authenticated user not admin' do
    given(:user) { create(:user) }
    background { sign_in(user) }

    scenario 'can not create bar_name' do
      visit root_path
      expect(page).to_not have_selector :link_or_button, 'Brands'
    end
  end
  describe 'Guest' do
    scenario 'can not create bar_name' do
      visit root_path
      expect(page).to_not have_selector :link_or_button, 'Brands'
    end
  end
end
