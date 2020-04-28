require 'rails_helper'

feature 'User create bar',
  %q{ User create a bar that can
be added to the ad for sale } do
  describe 'Authenticated user' do
    given!(:brand) { create(:brand, name: 'Airush') }
    given!(:bar_name) { create(:bar_name, name: 'One-Two-size', brand: brand) }
    given(:owner_user) { create(:user) }
    background { sign_in(owner_user) }

    scenario 'can create bar with valid data' do
      visit account_path(owner_user.account)
      click_on 'Add bar'

      within '.brand_name.mr-auto' do
        click_on brand.name
      end

      within "#bar_name_id_#{bar_name.id}" do
        click_on bar_name.name
      end

      select("2012", from: "Year").select_option
      select("5", from: "Quality").select_option
      fill_in "Price", with: 23000
      fill_in "Length", with: 48
      find(:css, '#bar_singly_sale').set(false)

      click_on 'Create Bar'

      expect(page).to have_content Bar.all.first.length
    end
    scenario 'can not create bar with invalid data' do
      visit account_path(owner_user.account)
      click_on 'Add bar'

      within '.brand_name.mr-auto' do
        click_on brand.name
      end

      within "#bar_name_id_#{bar_name.id}" do
        click_on bar_name.name
      end

      select("2012", from: "Year").select_option
      select("5", from: "Quality").select_option
      fill_in "Price", with: 23000
      fill_in "Length", with: ''
      find(:css, '#bar_singly_sale').set(false)

      click_on 'Create Bar'

      expect(page).to have_content "New bar of model #{bar_name.name}"
    end
  end

  describe 'Guest' do
    scenario 'can not create bar' do
      visit root_path
      expect(page).to_not have_selector :link_or_button, 'account'
    end
  end
end
