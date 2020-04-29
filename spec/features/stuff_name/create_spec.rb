require 'rails_helper'

feature 'Admin can create stuff_name' do
  describe 'Admin' do
    given!(:brand) { create(:brand) }
    given(:admin_user) { create(:user, role: 'Admin') }
    background { sign_in(admin_user) }

    scenario 'can create stuff_name with valid data' do
      visit root_path
      click_on 'Brands'

      within '.form_stuff_name' do
        fill_in 'stuff_name_name', with: 'NewStuffName'
        click_on 'Create Stuff name'
      end

      expect(page).to have_content 'NewStuffName'
    end
    scenario 'can not create stuff_name with invalid data'
  end
  describe 'Authenticated user not admin'
    scenario 'can not create stuff_name'
  describe 'Guest'
    scenario 'can not create stuff_name'
end
