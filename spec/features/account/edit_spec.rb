require 'rails_helper'

feature 'User can edit' do
  context 'Authenticated user' do
    given(:user) { create(:user) }
    background { sign_in(user) }

    scenario 'can edit account' do
      visit root_path
      click_on 'account'
      within '.account__info' do
        click_on 'edit'
      end

      fill_in 'Nickname', with: 'Jora'
      click_on 'Update Account'

      expect(page).to have_content 'nickname: Jora'
    end
  end
end
