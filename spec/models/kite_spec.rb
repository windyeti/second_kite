require 'rails_helper'

RSpec.describe Kite, type: :model do
  it { should belong_to :user }
  it { should belong_to :kite_name }

  it { should have_many(:ad_kites).dependent(:destroy) }
  it { should have_many(:ads).through(:ad_kites) }

  it { should validate_presence_of :year }
  it { should validate_presence_of :size }
  it { should validate_presence_of :price }
  it { should validate_presence_of :quality }

  it { should validate_numericality_of :year }
  it { should validate_numericality_of :size }
  it { should validate_numericality_of :price }
  it { should validate_numericality_of :quality }

  it { should validate_inclusion_of(:quality).in_range(1..5) }

  it 'have many attached best_views' do
    expect(Kite.new.best_photos).to be_an_instance_of(ActiveStorage::Attached::Many)
  end
  it 'have many attached trouble_views' do
    expect(Kite.new.trouble_photos).to be_an_instance_of(ActiveStorage::Attached::Many)
  end

  describe do
    let(:subject) { create(:kite) }
    it 'should be validate best_views via type image' do
      subject.best_photos.attach(
        [io: File.open(Rails.root.join('spec', 'rails_helper.rb')), filename: 'rails_helper.rb'])
      subject.valid?
      expect(subject.errors.full_messages).to include('Photo needs to be a jpeg or png!')
    end
  end

  describe 'custom create' do
    let!(:kite_params) { attributes_for(:kite, brand: "F-One", madel: "Bandit") }
    let!(:user) { create(:user) }
    it do
      expect(Kite.custom_create(kite_params, user)).to eq Kite.first
    end
  end

  describe 'custom update' do
    let!(:kite) { create(:kite) }
    let!(:kite_params) { { size: '22', brand: kite.kite_name.brand.name, madel: kite.kite_name.name } }
    it do
      expect(kite.custom_update(kite_params).size).to eq Kite.first.size
    end
  end

  describe 'new params' do
    let!(:params) { attributes_for(:kite, brand: "F-One", madel: "Bandit" ) }
    it { expect(Kite.custom_params( params )[:kite_name]).to be_an_instance_of KiteName }
  end
end
