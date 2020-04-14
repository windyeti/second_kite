require 'rails_helper'

feature 'User create an ad' do
  describe 'Authorized user' do
      given(:user) { create(:user) }

      background do
        sign_in(user)
        # TODO тут надо сделать заход в личный кабинет, а уже там жать кнопку Создать кайт
        visit new_ad_path
      end
    scenario 'can create an ad with valid data' do

      expect(page).to have_content 'Create new ad'

      fill_in 'Title', with: 'Title text'
      fill_in 'Description', with: 'Text'
      fill_in 'Total price', with: 'Text'

      click_on 'Create ad'

      expect(page).to have_content 'Title text'
    end
    scenario 'can not create an ad with invalid data' do

      fill_in 'Title', with: ''
      fill_in 'Description', with: 'Text'
      fill_in 'Total price', with: 'Text'

      click_on 'Create ad'

      expect(page).to_not have_content 'Title text'
    end
  end

  describe 'Guest' do
    scenario 'can not create an ad' do
      visit ads_path
      expect(page).to_not have_content 'Create new ad'
    end
  end
end
