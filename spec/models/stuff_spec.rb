require 'rails_helper'

RSpec.describe Stuff, type: :model do
  it { should belong_to :user }
  it { should belong_to :stuff_name }

  it 'have many attached best_photos' do
    expect(Stuff.new.best_photos).to be_an_instance_of(ActiveStorage::Attached::Many)
  end
  it 'have many attached trouble_photos' do
    expect(Stuff.new.trouble_photos).to be_an_instance_of(ActiveStorage::Attached::Many)
  end

  it { should validate_presence_of :price }
  it { should validate_presence_of :quality }
end
