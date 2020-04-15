require 'rails_helper'

feature 'Admin can delete brand' do
  context 'Admin' do
    given!(:brand) { create(:brand) }
    given(:admin_user) { create(:user, role: 'Admin') }
    background { sign_in(admin_user) }

    scenario 'can delete brand' do
      visit root_path
      click_on 'Brands'

      within '.list-group-item' do
        click_on 'delete'
      end

      within '.list-group' do
        expect(page).to_not have_css '.list-group-item'
      end
    end
  end

  context 'Authenticate user not admin' do
    given(:user) { create(:user) }
    background { sign_in(user) }

    scenario 'can not see admin panel' do
      visit root_path
      expect(page).to_not have_css '.admin_panel'
      expect(page).to_not have_selector(:link_or_button, 'Brands')
    end
  end

  context 'Guest' do
    scenario 'can not see admin panel' do
      visit root_path
      expect(page).to_not have_css '.admin_panel'
      expect(page).to_not have_selector(:link_or_button, 'Brands')
    end
  end
end
