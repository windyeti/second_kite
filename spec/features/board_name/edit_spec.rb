require 'rails_helper'

feature 'Admin edit board_name' do
  given(:admin_user) { create(:user, role: 'Admin') }
  given!(:brand) { create(:brand, name: 'Nash') }
  given!(:board_name) { create(:board_name, brand: brand, name: 'Liquid') }

  describe 'Admin' do
    background { sign_in(admin_user) }

    scenario 'with valid data can edit board_name' do
      visit root_path
      click_on 'Brands'
      click_on brand.name

      within '.board-name__item' do
        click_on 'edit'
      end

      fill_in 'board_name_name', with: 'Liquid NEW'
      click_on 'Update Board name'

      expect(page).to have_content 'Liquid NEW'
    end

    scenario 'with invalid data can not edit board_name' do
      visit root_path
      click_on 'Brands'
      click_on brand.name

      within '.board-name__item' do
        click_on 'edit'
      end

      fill_in 'board_name_name', with: ''
      click_on 'Update Board name'

      expect(page).to have_content 'Edit Board_name (Model)'

    end
  end
  describe 'Authenticated user not admin' do
    given(:user) { create(:user) }
    background { sign_in(user) }

    scenario 'can not edit board_name' do
      visit root_path
      expect(page).to_not have_selector(:link_or_button, 'Brands')
    end
  end

  describe 'Guest' do
    scenario 'can not edit board_name' do
      visit root_path
      expect(page).to_not have_selector(:link_or_button, 'Brands')
    end
  end
end
