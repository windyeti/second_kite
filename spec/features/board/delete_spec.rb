require 'rails_helper'

feature 'User delete his board' do
  describe 'Authenticated user' do
    context 'owner can delete board'
    context 'not owner can not delete board'
  end
  describe 'Guest' do
    context 'can not delete board'
  end
end
