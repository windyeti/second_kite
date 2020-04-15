require 'rails_helper'

feature 'Admin can create brand' do
  context 'Admin' do
    given(:admin_user) { create(:user, role: 'Admin') }
    given!(:type_equipment_kite) { create(:type_equipment, name: 'Kite') }
    given!(:type_equipment_board) { create(:type_equipment, name: 'Board') }
    given!(:type_equipment_bar) { create(:type_equipment, name: 'Bar') }
    background { sign_in(admin_user) }

    scenario 'can create with valid data' do
      visit root_path
      within '.admin_panel' do
        click_on 'Brands'
      end

      click_on 'Add brand'

      fill_in 'Name', with: 'F-One'
      find(:css, "#brand_type_equipment_ids_#{type_equipment_kite.id}").set(true)

      click_on 'Create Brand'

      within 'h4' do
        expect(page).to have_content 'F-One'
      end
      within '.type-equipment__name' do
        expect(page).to have_content type_equipment_kite.name
      end
    end

    scenario 'can not create with invalid data' do
      visit root_path
      within '.admin_panel' do
        click_on 'Brands'
      end

      click_on 'Add brand'

      fill_in 'Name', with: ''
      find(:css, "#brand_type_equipment_ids_#{type_equipment_bar.id}").set(true)

      click_on 'Create Brand'

      within 'h1' do
        expect(page).to have_content 'New brand'
      end
    end
  end
  context 'Authenticated user' do
    scenario 'can not create with invalid data' do
      visit root_path

      expect(page).to_not have_selector(:link_or_button, 'Add brand')
    end
  end
  context 'Guest' do
    scenario 'can not create with invalid data' do
      visit root_path

      expect(page).to_not have_selector(:link_or_button, 'Add brand')
    end
  end
end
