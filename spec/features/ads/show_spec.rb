require 'rails_helper'

feature 'User can see ad' do
  let(:user) { create(:user) }
  let!(:ad) { create(:ad, user: user) }

  scenario 'Anybody can see ad' do
    visit ads_path

    within '.ad' do
      click_on "#{ad.title}"
    end

    expect(page).to have_content ad.total_price
  end
end
