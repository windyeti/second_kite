require 'rails_helper'

feature 'User create board' do
  describe 'Authenticated user' do
    given!(:brand) { create(:brand, name: 'Liquid') }
    given!(:board_name) { create(:board_name, brand: brand, name: 'Quicker') }
    given(:user) { create(:user) }
    background { sign_in(user) }

    scenario 'with valid data can create board' do
      visit root_path
      click_on 'account'
      click_on 'Add board'

      click_on 'Liquid'
      click_on 'Quicker'

      #   ////
      # здесь заполнение полей продукта board
      #   ////

      click_on 'Create Board'

      expect(page).to have_content board_name.boards.first.length

    end
    scenario 'with invalid data can not create board'
  end
  describe 'Guest'
  scenario 'can not create board'
end
