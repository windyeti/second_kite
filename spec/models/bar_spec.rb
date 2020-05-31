require 'rails_helper'

RSpec.describe Bar, type: :model do
  it { should belong_to :user }
  it { should belong_to :bar_name }

  it { should have_many(:ad_bars).dependent(:destroy) }
  it { should have_many(:ads).through(:ad_bars) }

  it { should validate_presence_of :length }
  it { should validate_presence_of :price }
  it { should validate_presence_of :quality }
  it { should validate_presence_of :year }

  it { should validate_inclusion_of(:quality).in_range(1..5) }

  it 'have many attached best_views' do
    expect(Board.new.best_photos).to be_an_instance_of(ActiveStorage::Attached::Many)
  end
  it 'have many attached trouble_views' do
    expect(Board.new.trouble_photos).to be_an_instance_of(ActiveStorage::Attached::Many)
  end

  describe do
    let(:subject) { create(:board) }
    it 'should be validate best_views via type image' do
      subject.best_photos.attach(
        [io: File.open(Rails.root.join('spec', 'rails_helper.rb')), filename: 'rails_helper.rb'])
      subject.valid?
      expect(subject.errors.full_messages).to include('Photo needs to be a jpeg or png!')
    end
  end

  describe 'custom create' do
    let!(:bar_params) { attributes_for(:bar, brand: "F-One", madel: "Bandit") }
    let!(:user) { create(:user) }
    it do
      expect(Bar.custom_create(bar_params, user)).to eq Bar.first
    end
  end

  describe 'custom update' do
    let!(:bar) { create(:bar) }
    let!(:bar_params) { { length: '148', brand: bar.bar_name.brand.name, madel: bar.bar_name.name } }
    it do
      expect(bar.custom_update(bar_params).length).to eq Bar.first.length
    end
  end

  describe 'new params' do
    let!(:params) { attributes_for(:bar, brand: "F-One", madel: "Bandit" ) }
    it { expect(Bar.custom_params( params )[:bar_name]).to be_an_instance_of BarName }
  end
end
