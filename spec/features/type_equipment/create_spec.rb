require 'rails_helper'

feature 'Admin can create type equipment' do
  given!(:type_equipment_kite) { create(:type_equipment, name: 'Kite') }
  given!(:type_equipment_board) { create(:type_equipment, name: 'Board') }
  given!(:type_equipment_bar) { create(:type_equipment, name: 'Bar') }

  context 'Admin' do
    given(:admin_user) { create(:user, role: 'Admin') }
    background { sign_in(admin_user) }

    scenario 'can create with valid data' do
      visit root_path
      within '.admin_panel' do
        click_on 'Type equipment'
      end

      expect(page).to have_content 'List of type equipment'
      expect(page).to have_content 'Kite'

      click_on 'Add type equipment'

      fill_in 'Name', with: 'My Type Equipment'

      click_on 'Create Type equipment'

      expect(page).to have_content 'My Type Equipment'
    end

    scenario 'can not create with invalid data' do
      visit root_path
      within '.admin_panel' do
        click_on 'Type equipment'
      end

      expect(page).to have_content 'List of type equipment'
      expect(page).to have_content 'Kite'

      click_on 'Add type equipment'

      fill_in 'Name', with: ''

      click_on 'Create Type equipment'

      expect(page).to have_content 'New type equipment'
    end
  end

  context 'Authenticated user not admin' do
    given(:user) { create(:user) }
    background { sign_in(user) }

    scenario 'can not create with invalid data' do
      visit root_path

      expect(page).to_not have_selector(:link_or_button, 'Add type equipment')
    end
  end

  context 'Guest' do
    scenario 'can not create with invalid data' do
      visit root_path

      expect(page).to_not have_selector(:link_or_button, 'Add type equipment')
    end
  end
end
