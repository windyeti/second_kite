require 'rails_helper'

feature 'User can create stuff' do
  describe 'Authenticated user' do
    given(:brand) { create(:brand) }
    given(:stuff_name) { create(:stuff_name, brand: brand) }
    given(:user) { create(:user) }
    background { sign_in(user) }

    scenario 'can create stuff with valid data' do
      visit account_path(user.account)
      # TODO продолжить после создания stuff_name
      # click_on 'Add stuff'
      #
      # within '.brand_name.mr-auto' do
      #   click_on brand.name
      # end
      # within '.brand_name.mr-auto' do
      #   click_on stuff_name.name
      # end
      #
      # fill_in 'stuff_name_name', with: 'NewStuffName'
      # click_on 'Create Stuff name'
      #
      # expect(page).to have_content 'NewStuffName'
    end
    context 'can not create stuff with invalid data'
  end
  describe 'Guest'
    context 'can not create stuff'
end
