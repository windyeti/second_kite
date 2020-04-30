require 'rails_helper'

feature 'Admin can edit stuff_name' do
  given!(:brand) { create(:brand) }
  given!(:stuff_name) { create(:stuff_name, brand: brand) }

  describe 'Admin' do
    given(:admin_user) { create(:user, role: 'Admin') }
    background { sign_in(admin_user) }

    scenario 'can edit stuff_name with valid data' do
      visit brands_path
      click_on brand.name
      within "#stuff_name_id_#{stuff_name.id}" do
        click_on 'edit'
      end

      fill_in 'Name', with: 'NewStuffName'
      click_on 'Update Stuff name'

      expect(page).to have_content 'NewStuffName'
    end
    scenario 'cannot edit stuff_name with invalid data' do
      visit brands_path
      click_on brand.name
      within "#stuff_name_id_#{stuff_name.id}" do
        click_on 'edit'
      end

      fill_in 'Name', with: ''
      click_on 'Update Stuff name'

      expect(page).to have_content 'Edit Stuff_name'
    end
  end

  describe 'Authenticated user not admin' do
    given(:user) { create(:user) }
    background { sign_in(user) }

    scenario 'cannot edit stuff_name with invalid data' do
      visit root_path
      expect(page).to_not have_selector :link_or_button, 'Brands'
    end
  end
  describe 'Guest' do
    scenario 'cannot edit stuff_name with invalid data' do
      visit root_path
      expect(page).to_not have_selector :link_or_button, 'Brands'
    end
  end
end
