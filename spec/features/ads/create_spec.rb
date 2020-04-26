require 'rails_helper'

feature 'User create an ad' do
  describe 'Authorized user' do
      given(:owner_user) { create(:user, email: 'owner@mail.com') }
      given!(:kite) { create(:kite, user: owner_user) }
      given!(:board) { create(:board, user: owner_user) }

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

      expect(page).to have_content 'Title text'
      expect(find('.kites')).to have_content kite.kite_name.name

      visit root_path

      expect(page).to have_content kite.ads[0].title
      expect(page).to have_content board.ads[0].title
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
