require 'rails_helper'

RSpec.describe Brand, type: :model do
  it { should validate_presence_of :name }

  it { should have_many(:kite_names).dependent(:destroy) }
  it { should have_many(:board_names).dependent(:destroy) }
  it { should have_many(:bar_names).dependent(:destroy) }
  it { should have_many(:stuff_names).dependent(:destroy) }

  describe 'create brand' do
    let!(:params) { {brand: 'NewBrand'} }
    it { expect(Brand.custom_find_or_create_brand(params)).to eq Brand.first }
  end
  describe 'find brand' do
    let!(:brand) { create(:brand, name: 'OldBrand') }
    let!(:params) { {brand: 'OldBrand'} }
    it { expect(Brand.custom_find_or_create_brand(params)).to eq Brand.first }
  end
end
