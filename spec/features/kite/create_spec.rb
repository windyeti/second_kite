require 'rails_helper'

feature 'User create kite', js: true do
  given(:brand) { create(:brand, name: 'F-One', approve: true) }
  %w(Bandit Master Solo).each { |n| given!("kite_name_#{n}".to_sym) { create(:kite_name, brand: brand, name: n, approve: true) } }

  describe 'Authenticated user' do
    given(:user) { create(:user) }
    background { sign_in(user) }

    scenario 'with valid data can create kite' do
      visit root_path
      within '.login__down' do
        click_on 'account'
      end
      click_on 'Add kite'

      fill_in 'Brand', with: 'F-One'
      fill_in 'Madel', with: 'Solo'

      select("2012", from: "Year").select_option
      select("14", from: "Size").select_option
      fill_in 'Price', with: '345'
      select("4", from: "Quality").select_option

      click_on 'Create Kite'

      expect(page).to have_content 'Solo'
    end

    scenario 'with invalid data can not create kite' do
      visit root_path
      within '.login__down' do
        click_on 'account'
      end

      click_on 'Add kite'

      fill_in 'Brand', with: 'F-One'
      fill_in 'Madel', with: 'Solo'

      select("14", from: "Size").select_option
      fill_in 'Price', with: '345'
      select("4", from: "Quality").select_option

      click_on 'Create Kite'

      within 'h1' do
        expect(page).to_not have_content "Solo"
      end
    end
  end

  describe 'Guest' do
    scenario 'can not create kite' do
      visit root_path
      within '.login__down' do
        expect(page).to_not have_selector(:link_or_button, 'account')
      end
    end
   end
end
