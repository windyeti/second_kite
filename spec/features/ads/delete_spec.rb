require 'rails_helper'

feature 'User can delete ad' do
  describe 'Authenticated' do
    given(:author_user) { create(:user, email: 'author@mail.com') }
    given(:user) { create(:user) }
    given!(:ad) { create(:ad, user: author_user) }

    scenario 'author can delete ad' do
      sign_in(author_user)

      visit ads_path

      find('a.ad__delete-button').click

      expect(page).to_not have_content ad.title

    end
    scenario 'not author can not delete ad' do
      sign_in(user)

      visit ads_path

      expect(page).to_not have_selector('a.ad__delete-button')
    end
  end
  describe 'Guest' do
    scenario 'can not delete ad' do
      visit ads_path

      expect(page).to_not have_selector('a.ad__delete-button')
    end
  end
end
