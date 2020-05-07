require 'sphinx_helper'

feature 'User can w_search for kite specify kite model' do

  given(:user) { create(:user) }
  given!(:brand) { create(:brand, name: "Ozone") }
  given!(:kite_name_Edge) { create(:kite_name, brand: brand, name: "Edge") }
  given!(:kite_name_Zephyr) { create(:kite_name, brand: brand, name: "Zephyr") }
  given!(:kite_1) { create(:kite, user: user, kite_name: kite_name_Edge) }
  given!(:kite_2) { create(:kite, user: user, size: 17, kite_name: kite_name_Edge) }
  given!(:kite_3) { create(:kite, user: user, kite_name: kite_name_Zephyr) }
  given!(:ad) { create(:ad, user: user, kite_ids: [kite_2.id, kite_3.id]) }

  scenario 'Guest can searche for ad', js: true, sphinx: true do
    visit root_path

    ThinkingSphinx::Test.run do
      fill_in 'Search', with: 'Edge'
      select('Model of Kite', from: 'scope')
      click_on 'Search'

      click_on ad.title

      expect(page).to have_content 'Edge'
      expect(page).to have_content 'Zephyr'
    end
  end
end
