require 'rails_helper'

feature 'User can create product kite' do
  describe 'Authenticated user' do
    given(:user) { create(:user) }
    background { sign_in(user) }

    scenario 'can create product kite' do
      # TODO тут надо сделать заход в личный кабинет, а уже там жать кнопку Создать кайт
      # click_on 'Create kite'

      visit new_kite_path


      expect(page).to have_content 'Create kite'

      fill_in 'Title', with: 'Старый супер-пурер кайт'
      fill_in 'Total price', with: '1200'
      select("2012", from: "Year").select_option

      click_on 'Create kite'

      within 'h1' do
        expect(page).to have_content 'Старый супер-пурер кайт'
      end

    end
  end

  describe 'Guest'
    scenario 'can not create product kite'
      # TODO тут надо сделать заход в личный кабинет,
      # а уже тут нет кнопки Создать кайт
end
