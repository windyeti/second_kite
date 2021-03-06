require 'rails_helper'

feature 'User can see his account' do
  describe 'Authenticated user' do
    given(:user) { create(:user) }
    background { sign_in(user) }

    scenario 'can see his account' do
      visit root_path
      within '.login__down.text-right' do
        click_on 'account'
      end

      expect(page).to have_content "Hello, #{user.email}"
    end
  end
  describe 'Guest' do
    scenario 'can not see account' do
      visit root_path
      within '.login__down.text-right' do
        expect(page).to_not have_content 'account'
      end
    end
  end
end
