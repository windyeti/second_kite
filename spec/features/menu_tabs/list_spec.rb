require 'rails_helper'

feature 'User can seen list equipment that singly sale' do
  describe 'Guest' do
    given(:user) { create(:user, email: 'user@mail.com') }
    given!(:kite_singly_sale_1) { create(:kite, singly_sale: true, user: user) }
    given!(:kite_singly_sale_2) { create(:kite, singly_sale: true, user: user) }
    given!(:kite_singly_sale_3) { create(:kite, singly_sale: true, user: user) }
    given!(:kite_not_singly_sale_1) { create(:kite, singly_sale: false, user: user) }
    given!(:kite_not_singly_sale_2) { create(:kite, singly_sale: false, user: user) }

    given!(:ad) { create(:ad, kite_ids: [ kite_singly_sale_2.id, kite_singly_sale_3.id, kite_not_singly_sale_1.id ]) }

    scenario 'can seen list' do
      visit root_path
      click_on 'Only kites'

      expect(page).to have_selector '.list-group-item.kite', count: 2
    end
  end
end
