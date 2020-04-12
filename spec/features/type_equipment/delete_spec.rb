require 'rails_helper'

feature 'Admin can delete type equipment' do
  given!(:type_equipment) { create(:type_equipment) }

  context 'Admin' do
    given(:admin_user) { create(:user, role: 'Admin') }
    background { sign_in(admin_user) }

    scenario 'deleted type equipment' do
      visit root_path
      click_on 'Type equipment'

      save_and_open_page
      within '.list-group-item' do
        click_on 'delete'
      end

      within '.list-group' do
        expect(page).to_not have_content type_equipment.name
      end
    end
  end
  context 'Authenticated user' do
    given(:user) { create(:user) }
    background { sign_in(user) }

    scenario 'does not deleted type equipment' do
      visit root_path

      expect(page).to_not have_selector(:link_or_button, 'Type equipment')
    end
  end
  context 'Guest' do
    scenario 'does not deleted type equipment' do
      visit root_path

      expect(page).to_not have_selector(:link_or_button, 'Type equipment')
    end
  end
end
