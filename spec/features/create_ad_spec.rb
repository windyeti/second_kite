require 'rails_helper'

feature 'User create an ad' do
  describe 'Authorized user' do
      given(:user) { create(:user) }

      background do
        sign_in(user)
      end
    scenario 'can create an ad with valid data' do
      visit ads_path

      click_on 'Add ad'

      expect(page).to have_content 'Create new ad'
    end
    scenario 'can not create an ad with invalid data'
  end

  scenario 'Guest can not create an ad'
end
