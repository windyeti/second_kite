require 'rails_helper'

feature 'User create an ad' do
  describe 'Authorized user' do
      given(:owner_user) { create(:user, email: 'owner@mail.com') }
      given!(:brand_approve) { create(:brand, approve: true) }
      given!(:kite_name_approve) { create(:kite_name, brand: brand_approve, approve: true) }
      given!(:board_name_approve) { create(:board_name, brand: brand_approve, approve: true) }
      given!(:kite) { create(:kite, user: owner_user, kite_name: kite_name_approve) }
      given!(:board) { create(:board, user: owner_user, board_name: board_name_approve) }

      background { sign_in(owner_user) }

    scenario 'can create an ad with valid data' do
      visit root_path
      click_on 'account'

      click_on 'create new ad'

      find(:css, "#ad_kite_ids_#{kite.id}").set(true)
      find(:css, "#ad_board_ids_#{board.id}").set(true)
      fill_in 'Title', with: 'Title text'
      fill_in 'Description', with: 'Text Description'
      fill_in 'Total price', with: '321000'

      click_on 'Create ad'

      expect(page).to have_content 'Text Description'
      expect(find('.kites')).to have_content kite.kite_name.name

      visit root_path

      expect(page).to have_content 'Title text'
    end

    scenario 'can not create an ad with invalid data' do
      visit root_path
      click_on 'account'

      click_on 'create new ad'

      find(:css, "#ad_kite_ids_#{kite.id}").set(true)
      find(:css, "#ad_board_ids_#{board.id}").set(true)
      fill_in 'Title', with: ''
      fill_in 'Description', with: 'Text'
      fill_in 'Total price', with: 'Text'

      click_on 'Create ad'

      expect(page).to have_content 'Create new ad'
    end
  end

  describe 'Guest' do
    scenario 'can not create an ad' do
      visit ads_path
      expect(page).to_not have_selector :link_or_button, 'account'
    end
  end
end
