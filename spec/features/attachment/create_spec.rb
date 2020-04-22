require 'rails_helper'

feature 'User can attach photo to kite' do
  given(:brand) { create(:brand, name: 'F-One') }
  %w(Bandit Master Solo).each { |n| given!("kite_name_#{n}".to_sym) { create(:kite_name, brand: brand, name: n) } }
  given(:user) { create(:user) }
  background { sign_in(user) }

  describe 'can attache photo' do
    scenario 'type image/jpeg or image/png' do
      visit root_path
      click_on 'account'
      click_on 'Add kite'
      click_on 'F-One'
      click_on 'Bandit'

      select("2010", from: 'Year').select_option
      select("10", from: 'Size').select_option
      select("5", from: 'Quality').select_option
      fill_in 'Price', with: '12000'
      attach_file 'Best photos', [Rails.root.join('spec', 'support', 'test_red.jpg'), Rails.root.join('spec', 'support', 'test_orange.jpg')]
      click_on 'Create kite'

      save_and_open_page
      expect(find_all('.photo__img').length).to eq 2
    end
  end
  describe 'can not attache' do
    scenario 'file not image' do

    end
  end
end
