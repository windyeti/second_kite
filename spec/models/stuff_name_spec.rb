require 'rails_helper'

RSpec.describe StuffName, type: :model do
  it { should belong_to :brand }

  it { should have_many(:stuffs).dependent(:destroy) }

  it_behaves_like "Subscriptionable"

  it { should validate_presence_of :name }

  describe 'call find_stuff_name receive custom_find_or_create_madel' do
    let!(:brand) { create(:brand, name: 'OldBrand') }
    let!(:params) { {brand: 'OldBrand', madel: 'NewMadel'} }
    it do
      expect(StuffName).to receive(:custom_find_or_create_madel).with(brand, params)
      StuffName.find_stuff_name(params)
    end
  end

  describe 'find or create madel' do
    let!(:brand) { create(:brand, name: 'OldBrand') }
    let!(:params) { {brand: 'OldBrand', madel: 'NewMadel'} }
    it { expect(StuffName.custom_find_or_create_madel(brand, params).name).to eq 'NewMadel' }
  end
end
