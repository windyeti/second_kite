require 'rails_helper'

RSpec.describe KiteName, type: :model do
  it { should belong_to :brand }

  it { should have_many :kites }

  it_behaves_like "Subscriptionable"

  it { should validate_presence_of :name }

  describe 'call find_kite_name receive custom_find_or_create_madel' do
    let!(:brand) { create(:brand, name: 'OldBrand') }
    let!(:params) { {brand: 'OldBrand', madel: 'NewMadel'} }
    it do
      expect(KiteName).to receive(:custom_find_or_create_madel).with(brand, params)
      KiteName.find_kite_name(params)
    end
  end

  describe 'find or create madel' do
    let!(:brand) { create(:brand, name: 'OldBrand') }
    let!(:params) { {brand: 'OldBrand', madel: 'NewMadel'} }
    it { expect(KiteName.custom_find_or_create_madel(brand, params).name).to eq 'NewMadel' }
  end
end
