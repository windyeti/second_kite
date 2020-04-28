require 'rails_helper'

feature 'User can update bar' do
  describe 'Authenticated user' do
    given(:other_user) { create(:user, email: 'other@mail.com') }
    given(:owner_user) { create(:user) }
    given!(:bar) { create(:bar, user: owner_user) }

    context 'owner' do
      background { sign_in(owner_user) }

      scenario 'with valid data can update bar' do
        visit account_path(owner_user.account)

        within "#bar_id_#{bar.id}" do
          click_on 'edit'
        end

        select("2020", from: "Year").select_option
        click_on 'Update Bar'

        expect(page).to have_content 'Year: 2020'
      end
      scenario 'with invalid data can not update bar' do
        visit account_path(owner_user.account)

        within "#bar_id_#{bar.id}" do
          click_on 'edit'
        end

        fill_in 'Price', with: ''
        click_on 'Update Bar'

        expect(page).to have_content 'Edit bar of model'
      end
    end
    context 'not owner'
      background { sign_in(other_user) }

      scenario 'can not update bar' do
        visit account_path(owner_user.account)
        expect(page).to_not have_content "#bar_id_#{bar.id}"
      end
  end

  describe 'Guest' do
    scenario 'can not update bar' do
      visit root_path
      expect(page).to_not have_selector :link_or_button, 'account'
    end
  end
end
