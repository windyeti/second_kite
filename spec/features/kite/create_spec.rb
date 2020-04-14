require 'rails_helper'

feature 'User can create product kite' do
  describe 'Authenticated user' do
    given(:user) { create(:user) }
    background { sign_in(user) }

    scenario 'can create product kite' do
      # TODO тут надо сделать заход в личный кабинет,
      # а уже там жать кнопку Создать кайт
      # click_on 'Create kite'

      visit new_kite_path

      expect(page).to have_content 'Create kite'

      fill_in 'Brand', with: 'F-One'
      fill_in 'Name', with: 'Bandit'
      select("2012", from: "Year").select_option
      select("14", from: "Size").select_option
      select("4", from: "Quality").select_option
      fill_in 'Price', with: '1200'

      click_on 'Create kite'

      expect(page).to have_content 'F-One'

    end
  end

  describe 'Guest'
    scenario 'can not create product kite'
      # TODO тут надо сделать заход в личный кабинет,
      # а уже тут нет кнопки Создать кайт
end
