require 'rails_helper'

feature 'User create kite' do
  given(:brand) { create(:brand, name: 'F-One') }
  %w(Bandit Master Solo).each { |n| given!("kite_name_#{n}".to_sym) { create(:kite_name, brand: brand, name: n) } }

  describe 'Authenticated user' do
    given(:user) { create(:user) }
    background { sign_in(user) }

    scenario 'with valid data can create kite' do
      visit root_path
      within '.login__down' do
        click_on 'account'
      end
      click_on 'Add kite'

      within '.brand_name' do
        click_on 'F-One'
      end

      within '.kite_name_solo' do
        click_on 'Solo'
      end

      select("2012", from: "Year").select_option
      select("14", from: "Size").select_option
      fill_in 'Price', with: '345'
      select("4", from: "Quality").select_option

      click_on 'Create kite'

      expect(page).to have_content 'Solo'
    end

    scenario 'with invalid data can not create kite' do
      visit root_path
      within '.login__down' do
        click_on 'account'
      end

      click_on 'Add kite'

      within '.brand_name' do
        click_on 'F-One'
      end

      within '.kite_name_solo' do
        click_on 'Solo'
      end

      select("14", from: "Size").select_option
      fill_in 'Price', with: '345'
      select("4", from: "Quality").select_option

      click_on 'Create kite'

      within 'h1' do
        expect(page).to have_content "New kite model Solo"
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
