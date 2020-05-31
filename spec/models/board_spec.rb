require 'rails_helper'

RSpec.describe Board, type: :model do
  it { should belong_to :user }
  it { should belong_to :board_name }

  it { should have_many(:ad_boards).dependent(:destroy) }
  it { should have_many(:ads).through(:ad_boards) }

  it { should validate_presence_of :length }
  it { should validate_presence_of :width }
  it { should validate_presence_of :year }
  it { should validate_presence_of :quality }
  it { should validate_presence_of :price }

  it { should validate_numericality_of :length }
  it { should validate_numericality_of :width }
  it { should validate_numericality_of :year }
  it { should validate_numericality_of :quality }
  it { should validate_numericality_of :price }

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
    let!(:board_params) { attributes_for(:board, brand: "F-One", madel: "Bandit") }
    let!(:user) { create(:user) }
    it do
      expect(Board.custom_create(board_params, user)).to eq Board.first
    end
  end

  describe 'custom update' do
    let!(:board) { create(:board) }
    let!(:board_params) { { length: '100', brand: board.board_name.brand.name, madel: board.board_name.name } }
    it do
      expect(board.custom_update(board_params).length).to eq Board.first.length
    end
  end

  describe 'new params' do
    let!(:params) { attributes_for(:board, brand: "F-One", madel: "Bandit" ) }
    it { expect(Board.custom_params( params )[:board_name]).to be_an_instance_of BoardName }
  end
end
