require 'rails_helper'

feature 'Admin delete board_name', js: true do
  given(:admin_user) { create(:user, role: 'Admin') }
  given!(:brand) { create(:brand, name: 'Nash') }
  given!(:board_name) { create(:board_name, brand: brand, name: 'Liquid') }

  describe 'Admin' do
    background { sign_in(admin_user) }

    scenario 'can delete board_name' do
      visit root_path
      click_on 'Brands'
      click_on brand.name

      within '.board-name__item' do
        accept_alert { click_on 'delete' }
      end

      expect(page).to_not have_content 'Liquid'
      # TODO сделать ссылкой
      # expect(page).to_not have_selector(:link_or_button, 'Liquid')
    end
  end
  describe 'Authenticated user not admin' do
    given(:user) { create(:user) }
    background { sign_in(user) }

    scenario 'can not delete board_name' do
      visit root_path
      expect(page).to_not have_selector(:link_or_button, 'Brands')
    end
  end
  describe 'Guest' do
    scenario 'can not delete board_name' do
      visit root_path
      expect(page).to_not have_selector(:link_or_button, 'Brands')
    end
  end
end
