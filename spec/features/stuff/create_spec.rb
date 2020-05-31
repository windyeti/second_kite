require 'rails_helper'

feature 'User can create stuff', js: true do
  describe 'Authenticated user' do
    given!(:brand) { create(:brand) }
    given!(:stuff_name) { create(:stuff_name, brand: brand) }
    given(:user) { create(:user) }
    background { sign_in(user) }

    scenario 'can create stuff with valid data' do
      visit account_path(user.account)

      click_on 'Add stuff'

      fill_in 'Brand', with: brand.name
      fill_in 'Madel', with: stuff_name.name

      fill_in 'Price', with: 123
      select("1999", from: 'Year').select_option
      select("5", from: 'Quality').select_option
      fill_in 'Description', with: 'Text text text text'

      click_on 'Create Stuff'
sleep 1
      expect(page).to have_content "#{stuff_name.name} - #{stuff_name.stuffs.first.description.truncate(15)} - 123₽"
    end
    scenario 'can not create stuff with invalid data' do
      visit account_path(user.account)

      click_on 'Add stuff'

      within '.brand_name.mr-auto' do
        click_on brand.name
      end
      within '.stuff_name.mr-auto' do
        click_on stuff_name.name
      end

      fill_in 'stuff_price', with: ''
      select("1999", from: 'Year').select_option
      select("5", from: 'Quality').select_option

      click_on 'Create Stuff'

      expect(page).to have_content 'Price can\'t be blank'
      expect(page).to have_content 'New stuff model'
    end
  end

  describe 'Guest' do
    scenario 'cannot create stuff' do
      visit root_path
      expect(page).to_not have_selector :link_or_button, 'account'
    end
  end
end
