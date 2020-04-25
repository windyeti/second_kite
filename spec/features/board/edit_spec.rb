require 'rails_helper'

feature 'User edit his board' do
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
        save_and_open_page
        select("1999", from: "Year").select_option
        click_on "Update Board"

        expect(page).to have_content 'Year: 1999'
      end
      scenario 'with invalid data can not edit board' do
        visit account_path(owner_user.account)
        within '.boards' do
          click_on 'edit'
        end
        save_and_open_page
        fill_in 'Price', with: ''
        click_on "Update Board"

        expect(page).to have_content "Edit board of model #{board.board_name.name}"
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
