require 'rails_helper'

feature 'Admin can edit brand' do
  context 'Admin' do
    given!(:brand) { create(:brand, name: 'Gaastra') }
    given(:admin_user) { create(:user, role: 'Admin') }
    background { sign_in(admin_user) }

    scenario 'with valid data can edit' do
      visit root_path
      click_on 'Brands'

      expect(page).to have_content 'Gaastra'

      within '.brand' do
        click_on 'edit'
      end

      fill_in 'Name', with: 'GA'
      click_on 'Update Brand'

      expect(page).to have_content 'GA'

    end
    scenario 'with invalid data can not edit' do

    end
  end
  context 'Authenticated user not admin' do
    scenario 'can not edit' do

    end
  end
  context 'Guest' do
    scenario 'can not edit' do

    end
  end
end
