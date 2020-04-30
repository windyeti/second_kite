require 'rails_helper'

feature 'User can edit stuff' do
  given(:other_user) { create(:user, email: 'other@mail.com') }
  given(:owner_user) { create(:user) }
  given!(:stuff) { create(:stuff, user: owner_user) }

  describe 'Authenticated user' do
    background { sign_in(owner_user) }

    context 'owner' do
      scenario 'can edit stuff with valid data' do
        visit account_path(owner_user.account)
        within "#stuff_id_#{stuff.id}" do
          click_on 'edit'
        end
        select('1998', from: 'Year').select_option
        click_on 'Update Stuff'

        expect(page).to have_content 'Year: 1998'
      end
      scenario 'cannot edit stuff with invalid data' do
        visit account_path(owner_user.account)
        within "#stuff_id_#{stuff.id}" do
          click_on 'edit'
        end
        fill_in 'Price', with: ''
        click_on 'Update Stuff'

        expect(page).to have_content 'Edit stuff model'
      end
    end
    context 'not owner' do
      background { sign_in(other_user) }
      scenario 'cannot edit stuff' do
        visit account_path(other_user.account)
        expect(page).to_not have_css "#stuff_id_#{stuff.id}"
      end
    end
  end
  describe 'Guest' do
    scenario 'cannot edit stuff' do
      visit root_path
      expect(page).to_not have_selector :link_or_button, 'account'
    end
  end
end
