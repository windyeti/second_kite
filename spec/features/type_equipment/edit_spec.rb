require 'rails_helper'

feature 'User update type equipment' do
  given!(:type_equipment_kite) { create(:type_equipment, name: 'Kite') }

  given(:admin_user) { create(:user, role: 'Admin') }

  context 'Admin' do
    background do
      sign_in(admin_user)
    end

    scenario 'with valid data can update type equipment' do
      visit root_path
      click_on 'Type equipment'

      click_on 'edit'

      fill_in 'Name', with: 'Super Kite'

      click_on 'Update Type equipment'
save_and_open_page

      expect(page).to have_content 'Super Kite'
    end

    context 'with valid data can update' do

    end
    context 'with invalid data can not update' do

    end
  end

  describe 'Authenticated user not admin'
  describe 'Guest'
end
