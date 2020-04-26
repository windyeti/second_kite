require 'rails_helper'

feature 'User delete his board', js: true do
  describe 'Authenticated user' do
    given(:owner_user) { create(:user) }
    given!(:board) { create(:board, year: 2010, user: owner_user) }
    given(:other_user) { create(:user, email: 'other@mail.com') }

    scenario 'owner can delete board' do
      sign_in(owner_user)
      visit root_path
      click_on 'account'

      expect(page).to have_css "#board_id_#{board.id}"

      within '.boards' do
        accept_alert { find(:css, '.link-delete').click }
      end

      expect(page).to_not have_css "#board_id_#{board.id}"
    end

    scenario 'not owner can not delete board' do
      sign_in(other_user)
      visit root_path
      click_on 'account'

      expect(page).to_not have_css "#board_id_#{board.id}"
    end
  end
  describe 'Guest' do
    scenario 'can not delete board' do
      visit root_path

      expect(page).to_not have_selector :link_or_button, 'account'
    end
  end
end
