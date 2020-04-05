require 'rails_helper'

feature 'User sees a button Add ad' do
  describe 'Authorized user' do
      given(:user) { create(:user) }

      background do
        sign_in(user)
      end
    scenario 'can sees a button Add ad' do
      visit ads_path

      expect(page).to have_content 'create new ad'
    end
  end

  describe 'Unauthorized user' do
    scenario 'can not sees a button Add ad' do
      visit ads_path

      expect(page).to_not have_content 'create new ad'
    end
  end
end
