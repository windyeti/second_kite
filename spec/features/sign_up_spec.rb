require 'rails_helper'

feature 'Guest', %q{
Guest can sign up to create ad
about sell equipment
} do

  describe 'can sign up' do
    scenario 'with unique email' do
      visit signup_path

      fill_in 'Email', with: 'unique_email@mail.ru'
      fill_in 'Password', with: '123456'
      fill_in 'Password_confirmation', with: '123456'
      click_on 'Sign up'

      expect(page).to have_content 'You are successful sing up'
      expect(page).to have_content 'Log in'
    end
  end

  describe 'can not sign up' do
    scenario 'with not unique email'
  end
end
