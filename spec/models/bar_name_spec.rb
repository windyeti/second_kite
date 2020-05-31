require 'rails_helper'

RSpec.describe BarName, type: :model do
  it { should belong_to :brand }

  it { should have_many(:bars).dependent(:destroy) }

  it_behaves_like "Subscriptionable"

  it { should validate_presence_of :name }

  describe 'call find_bar_name receive custom_find_or_create_madel' do
    let!(:brand) { create(:brand, name: 'OldBrand') }
    let!(:params) { {brand: 'OldBrand', madel: 'NewMadel'} }
    it do
      expect(BarName).to receive(:custom_find_or_create_madel).with(brand, params)
      BarName.find_bar_name(params)
    end
  end

  describe 'find or create madel' do
    let!(:brand) { create(:brand, name: 'OldBrand') }
    let!(:params) { {brand: 'OldBrand', madel: 'NewMadel'} }
    it { expect(BarName.custom_find_or_create_madel(brand, params).name).to eq 'NewMadel' }
  end
end
