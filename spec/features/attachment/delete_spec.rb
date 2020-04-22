require 'rails_helper'

feature 'User delete attached file', js: true do
  describe 'Authenticated user' do
    given(:owner_user) { create(:user, email: 'owner@mail.com') }
    given(:other_user) { create(:user, email: 'other@mail.com') }
    given!(:kite) { create(:kite,  :with_attachments, user: owner_user) }

    context 'owner kite' do
      background { sign_in(owner_user) }

      scenario 'can delete attached file' do
        visit root_path
        click_on 'account'


        find('.link-edit a').click


        accept_alert do
          find('.photo_link__container a').click
        end

        expect(page).to_not have_css '.photo__container'
      end
    end

    context 'not owner can not delete attached file' do
      background { sign_in(other_user) }

      scenario 'can not delete attached file' do
        visit root_path
        click_on 'account'

        expect(page).to_not have_css '.link-edit'
      end

    end
  end
end
