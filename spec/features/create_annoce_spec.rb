require 'rails_helper.rb'

feature 'User create ad', %q{
Authenticated user can
create an ad to sell their equipment.
} do
  describe 'Authenticated user' do
    scenario 'can create an ad with valid data'
    scenario 'can not create an ad with invalid data'
  end
  describe 'Unauthenticated user' do
    scenario 'can not create an ad'
  end
end
