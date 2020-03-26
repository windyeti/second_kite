require 'rails_helper'

feature 'Guest', %q{
Guest can sign up to create ad
about sell equipment
} do

  describe 'can sign up' do
    background do
      visit new_user_registration_path
      fill_in 'Email', with: 'unique_email@mail.ru'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_on 'Sign up'
    end
    scenario 'with unique email' do

      open_email('unique_email@mail.ru')
      current_email.click_link 'Confirm my account'

      # current_email.save_and_open
      expect(page).to have_content 'Your email address has been successfully confirmed.'

    end
  end

  # describe 'can not sign up' do
  #   scenario 'with not unique email'
  # end
end
