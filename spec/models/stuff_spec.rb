require 'rails_helper'

RSpec.describe Stuff, type: :model do
  it { should belong_to :user }
  it { should belong_to :stuff_name }

  it { should have_many(:ad_stuffs).dependent(:destroy) }
  it { should have_many(:ads).through(:ad_stuffs) }

  it 'have many attached best_photos' do
    expect(Stuff.new.best_photos).to be_an_instance_of(ActiveStorage::Attached::Many)
  end
  it 'have many attached trouble_photos' do
    expect(Stuff.new.trouble_photos).to be_an_instance_of(ActiveStorage::Attached::Many)
  end

  it { should validate_presence_of :price }
  it { should validate_presence_of :quality }
  it { should validate_presence_of :year }

  it { should validate_inclusion_of(:quality).in_range(1..5) }

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
    let!(:stuff_params) { attributes_for(:stuff, brand: "F-One", madel: "Bandit") }
    let!(:user) { create(:user) }
    it do
      expect(Stuff.custom_create(stuff_params, user)).to eq Stuff.first
    end
  end

  describe 'custom update' do
    let!(:stuff) { create(:stuff) }
    let!(:stuff_params) { { price: 200, brand: stuff.stuff_name.brand.name, madel: stuff.stuff_name.name } }
    it do
      expect(stuff.custom_update(stuff_params).price).to eq Stuff.first.price
    end
  end

  describe 'new params' do
    let!(:params) { attributes_for(:stuff, brand: "F-One", madel: "Bandit" ) }
    it { expect(Stuff.custom_params( params )[:stuff_name]).to be_an_instance_of StuffName }
  end
end
