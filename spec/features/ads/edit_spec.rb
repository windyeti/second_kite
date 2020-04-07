require 'rails_helper'

feature '', %q{
The user can edit his ad to update information.
} do
  given(:user) { create(:user) }
  given(:other_user) { create(:user, email: "email_other_user@mail.com") }
  given!(:ad) { create(:ad, user: user) }
  describe 'Authenticated user' do

    scenario 'can edit his ad with valid data' do
      sign_in(user)

      visit ads_path

      within 'td:first-child' do
        click_on 'edit'
      end

      fill_in 'Title', with: 'New my title'

      click_on 'Update ad'

      expect(page).to have_content 'New my title'
    end

    scenario 'can not edit his ad with invalid data' do
      sign_in(user)

      visit ads_path

      within 'td:first-child' do
      click_on 'edit'
      end


      fill_in 'Title', with: ''

      click_on 'Update ad'

      expect(page).to have_content 'Edit ad'
    end
  end

  describe 'Authenticated user not author' do
    scenario 'can not edit ad' do
      sign_in(other_user)
      visit ads_path

      expect(page).to_not have_selector :link_or_button, 'Edit'
    end
  end

  describe 'Guest' do
    scenario 'can not edit ad' do
      visit ads_path
      expect(page).to_not have_selector :link_or_button, 'Edit'
    end

  end
end
