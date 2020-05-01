require 'rails_helper'

feature 'User can seen list equipment that singly sale' do
  describe 'Guest' do
    given(:user) { create(:user) }
    given!(:kites_singly_sale) { create_list(:kite, 5, singly_sale: true, user: user) }
    given!(:kites_not_singly_sale) { create_list(:kite, 3, singly_sale: false, user: user) }

    scenario 'can seen list' do
      visit root_path
      click_on 'Only kites'

      expect(page).to have_selector '.list-group-item.kite', count: 5
    end
  end
end
