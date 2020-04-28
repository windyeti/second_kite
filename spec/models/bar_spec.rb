require 'rails_helper'

RSpec.describe Bar, type: :model do
  it { should belong_to :user }
  it { should belong_to :bar_name }

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
end
