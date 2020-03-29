require 'rails_helper'

feature 'User create an ad' do
  describe 'Authorized user' do
      given(:user) { create(:user) }

      background do
        sign_in(user)
      end
    scenario 'can create an ad with valid data' do
      visit ads_path

      expect(page).to have_content 'Add ad'
    end
  end

  describe 'Unauthorized user' do
    scenario 'Guest can not create an ad' do
      visit ads_path

      expect(page).to_not have_content 'Add ad'
    end
  end
end
