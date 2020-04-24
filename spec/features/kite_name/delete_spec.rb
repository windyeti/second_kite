require 'rails_helper'

feature 'Admin can delete kite name', js: true do
  given!(:brand) { create(:brand, name: 'PrettyBrand' ) }
  given!(:kite_name) { create(:kite_name, name: 'SuperNewlyModel', brand: brand ) }

  context 'Admin' do
    given(:admin_user) { create(:user, role: 'Admin' ) }
    background { sign_in(admin_user) }

    scenario 'can delete' do
      visit root_path

      within '.admin_panel' do
        click_on 'Brands'
      end

      within '.brand_name' do
        click_on 'PrettyBrand'
      end
save_and_open_page

      within '.kite-name__item' do
        accept_alert { click_on 'delete' }
      end
      expect(page).to have_content "List of kite names for brand PrettyBrand"
      expect(page).to_not have_selector(:link_or_button, 'SuperNewlyModel')
    end
  end
  context 'Authenticated user not admin' do
    given(:user) { create(:user) }
    background { sign_in(user) }

    scenario 'can not delete' do
      visit root_path
      expect(page).to_not have_css('.admin_panel')
    end
  end
  context 'Guest' do
    scenario 'can not delete' do
      visit root_path
      expect(page).to_not have_css('.admin_panel')
    end
  end
end
