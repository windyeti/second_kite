require 'rails_helper'

feature 'Admin create brand_name', %q{
  Admin create board_name to user can create
  board via board_name
} do
  given(:admin_user) { create(:user, role: 'Admin') }
  given!(:brand) { create(:brand, name: 'Nash') }

  describe 'Admin', js: true do
    background { sign_in(admin_user) }

    scenario 'with valid data can create board_name' do
      visit root_path
      click_on 'Brands'

      within '.brand_name' do
        click_on brand.name
      end

        fill_in 'board_name_name', with: 'Liquid'
        click_on 'Create Board name'

      within '.board-name__list' do
        expect(page).to have_selector(:link_or_button, 'Liquid')
      end
    end
    scenario 'with invalid data can not create board_name' do
      visit root_path
      click_on 'Brands'

      within '.brand_name' do
        click_on brand.name
      end

      fill_in 'board_name_name', with: ''
      click_on 'Create Board name'

      within '.board-name__errors' do
        expect(page).to have_content 'Name can\'t be blank'
      end
    end
  end

  describe 'Authenticated user not admin' do
    given(:other_user) { create(:user) }
    background { sign_in(other_user) }
    scenario 'can not create board_name' do
      visit root_path
      expect(page).to_not have_selector(:link_or_button, 'Brands')
    end
  end
  describe 'Guest' do
    scenario 'can not create board_name' do
      visit root_path
      expect(page).to_not have_selector(:link_or_button, 'Brands')
    end
  end

end
