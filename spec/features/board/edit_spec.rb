require 'rails_helper'

feature 'User edit his board', js: true do
  describe 'Authenticated user' do
    given(:owner_user) { create(:user) }
    given!(:board) { create(:board, year: 2010, user: owner_user) }
    given(:other_user) { create(:user, email: 'other@mail.com') }
    background { sign_in(owner_user) }

    context 'owner' do
      scenario 'with valid data can edit board' do
        visit account_path(owner_user.account)
        within '.boards' do
          click_on 'edit'
        end
        fill_in 'Price', with: 100500
        click_on "Update Board"

        expect(page).to have_content "#{board.board_name.name} - #{board.length}x#{board.width}см - 100500₽"
      end
      scenario 'with invalid data can not edit board' do
        visit account_path(owner_user.account)
        within '.boards' do
          click_on 'edit'
        end
        fill_in 'Price', with: ''
        click_on "Update Board"

        expect(page).to have_content "Update board"
        expect(page).to have_content "Price can't be blank"
      end
    end
    scenario 'not owner can not edit board' do
      sign_in(other_user)

      visit account_path(other_user.account)
      within '.boards' do
        expect(page).to_not have_selector(:link_or_button, 'edit')
      end
    end
  end
  describe 'Guest' do
    scenario 'can not edit board' do
      visit root_path
      expect(page).to_not have_selector(:link_or_button, 'account')
    end
  end
end
