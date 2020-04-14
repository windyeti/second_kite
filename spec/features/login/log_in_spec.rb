require 'rails_helper'

feature 'User' do
  given!(:user) { create(:user, email: 'unique_email@mail.ru') }
  scenario 'can log in with valid data' do

    visit new_user_session_path

    fill_in 'Email', with: 'unique_email@mail.ru'
    fill_in 'Password', with: '123456'

    within '#new_user' do
      click_on 'Log in'
    end

    expect(page).to have_content 'Signed in successfully'
  end
  scenario 'can not log in with invalid data' do
    visit new_user_session_path

    fill_in 'Email', with: 'unique_email@mail.ru'
    fill_in 'Password', with: ''

    within '#new_user' do
      click_on 'Log in'
    end

    expect(page).to have_content 'Invalid Email or password'

    within '.login' do
      expect(page).to have_content 'Log in'
    end
  end
end
