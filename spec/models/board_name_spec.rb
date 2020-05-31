require 'rails_helper'

RSpec.describe BoardName, type: :model do
  it { should belong_to :brand }

  it { should have_many :boards }

  it_behaves_like "Subscriptionable"

  it { should validate_presence_of :name }

  describe 'call find_board_name receive custom_find_or_create_madel' do
    let!(:brand) { create(:brand, name: 'OldBrand') }
    let!(:params) { {brand: 'OldBrand', madel: 'NewMadel'} }
    it do
      expect(BoardName).to receive(:custom_find_or_create_madel).with(brand, params)
      BoardName.find_board_name(params)
    end
  end

  describe 'find or create madel' do
    let!(:brand) { create(:brand, name: 'OldBrand') }
    let!(:params) { {brand: 'OldBrand', madel: 'NewMadel'} }
    it { expect(BoardName.custom_find_or_create_madel(brand, params).name).to eq 'NewMadel' }
  end
end
