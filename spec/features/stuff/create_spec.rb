require 'rails_helper'

feature 'User can create stuff' do
  describe 'Authenticated user' do
    given!(:brand) { create(:brand) }
    given!(:stuff_name) { create(:stuff_name, brand: brand) }
    given(:user) { create(:user) }
    background { sign_in(user) }

    scenario 'can create stuff with valid data' do
      visit account_path(user.account)

      click_on 'Add stuff'

      within '.brand_name.mr-auto' do
        click_on brand.name
      end
      within '.stuff_name.mr-auto' do
        click_on stuff_name.name
      end

      fill_in 'stuff_price', with: 123
      select("1999", from: 'Year').select_option
      select("5", from: 'Quality').select_option

      click_on 'Create Stuff'

      expect(page).to have_content 'Year: 1999'
    end
    context 'can not create stuff with invalid data'
  end
  describe 'Guest'
    context 'can not create stuff'
end
