require 'rails_helper'

feature '' do
  describe 'Authenticated user' do
    given(:user) { create(:user) }
    background { sign_in(user) }

    scenario 'can see his account' do
      visit root_path
      within '.login__account' do
        click_on 'account'
      end

      expect(page).to have_content "Hello, #{user.email}"
    end
  end
  describe 'Guest'
    scenario 'can not see account'
end
