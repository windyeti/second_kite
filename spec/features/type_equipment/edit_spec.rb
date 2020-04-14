require 'rails_helper'

feature 'User update type equipment' do
  given!(:type_equipment_kite) { create(:type_equipment, name: 'Old Name Kite') }


  context 'Admin' do
    given(:admin_user) { create(:user, role: 'Admin') }
    background do
      sign_in(admin_user)
    end

    scenario 'with valid data can update type equipment' do
      visit root_path
      click_on 'Type equipment'

      click_on 'edit'

      fill_in 'Name', with: 'Super Kite'

      click_on 'Update Type equipment'

      expect(page).to have_content 'Super Kite'
    end

    scenario 'with invalid data can not update' do
      visit root_path
      click_on 'Type equipment'

      click_on 'edit'

      fill_in 'Name', with: ''

      click_on 'Update Type equipment'

      expect(page).to have_content 'Edit type equipment'
    end
  end

  describe 'Authenticated user not admin' do
    given(:user) { create(:user) }
    background do
      sign_in(user)
    end
    scenario 'can not update type equipment' do
      visit root_path

      expect(page).to_not have_content 'Type equipment'
    end
  end
  describe 'Guest' do
    scenario 'can not update type equipment' do
      visit root_path

      expect(page).to_not have_content 'Type equipment'
    end
  end
end
