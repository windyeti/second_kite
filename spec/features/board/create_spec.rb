require 'rails_helper'

feature 'User create board', js: true do
  describe 'Authenticated user' do
    given!(:brand) { create(:brand, name: 'NP') }
    given!(:board_name) { create(:board_name, brand: brand, name: 'Quicker') }
    given(:user) { create(:user) }
    background { sign_in(user) }

    scenario 'with valid data can create board' do
      visit root_path
      click_on 'account'
      click_on 'Add board'

      fill_in 'Brand', with: 'NP'
      fill_in 'Madel', with: 'Quicker'

      fill_in 'Length', with: '143'
      fill_in 'Width', with: '35'
      find(:css, "#board_pads").set(true)
      find(:css, "#board_fins").set(false)
      find(:css, "#board_singly_sale").set(false)
      select("2010", from: "Year").select_option
      select("3", from: "Quality").select_option
      fill_in 'Price', with: '23000'

      click_on 'Create Board'

      expect(page).to have_content 'Quicker'
    end

    scenario 'with invalid data can not create board' do
      visit root_path
      click_on 'account'
      click_on 'Add board'

      fill_in 'Brand', with: 'NP'
      fill_in 'Madel', with: 'Quicker'

      click_on 'Create Board'

      expect(page).to have_content "New board"
      expect(page).to have_content "Price can't be blank"
    end
  end
  describe 'Guest' do
    scenario 'can not create board' do
      visit root_path
      expect(page).to_not have_selector(:link_or_button, 'account')
    end
  end
end
