require 'rails_helper'

feature 'Authenticated user edit kite' do
  describe 'Authenticated user' do
    given(:owner_user) { create(:user) }
    given!(:kite) { create(:kite, user: owner_user) }

    context 'owner' do
      background { sign_in(owner_user) }

      scenario 'with valid data can edit his kite' do
        visit root_path
        within '.login__down' do
          click_on 'account'
        end

        within '.link-edit' do
          click_on 'edit'
        end

        select('9', from: 'Size').select_option

        click_on 'Update Kite'

        expect(page).to have_content 'Size: 9'
      end
      scenario 'with invalid data can not edit his kite' do
        visit root_path
        within '.login__down' do
          click_on 'account'
        end

        within '.link-edit' do
          click_on 'edit'
        end

        fill_in 'Price', with: ''

        click_on 'Update Kite'

        expect(page).to have_content "Edit kite model #{kite.kite_name.name}"
      end
    end

    context 'not owner' do
      given(:other_user) { create(:user, email: 'other_user@mail.com') }
      background { sign_in(other_user) }

      scenario 'can not edit kite' do
        visit root_path
        expect(page).to_not have_css '.admin_panel'
      end
    end
  end

  describe 'Guest' do
    scenario 'can not edit kite' do
      visit root_path
      expect(page).to_not have_css '.admin_panel'
    end
  end

end
