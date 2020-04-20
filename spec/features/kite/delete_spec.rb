require 'rails_helper'

feature 'User delete kite', js: true do
  given(:owner_user) { create(:user) }
  given(:other_user) { create(:user, email: 'other@mail.com') }
  given!(:kite) { create(:kite, user: owner_user) }

  describe 'Authenticated user' do
    scenario 'owner can delete his kite' do
      sign_in(owner_user)
      visit root_path
      within '.login__down' do
        click_on 'account'
      end

      within '.link-delete' do
        click_on 'delete'
      end

      expect(page).to_not have_css "#kite_id_#{kite.id}"
      expect(page).to_not have_content "List of ads"
    end
  end
    scenario 'not owner can not delete' do
      sign_in(other_user)
      visit root_path
      within '.login__down' do
        click_on 'account'
      end

      expect(page).to_not have_content "#{kite.kite_name.name} - #{kite.size}m2 - #{kite.price}"
    end
  describe 'Guest'
    scenario 'can not delete' do
      visit root_path

      expect(page).to_not have_selector(:link_or_button, 'account')
    end
end
