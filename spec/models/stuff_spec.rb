require 'rails_helper'

RSpec.describe Stuff, type: :model do
  it { should belong_to :user }
  it { should belong_to :stuff_name }

  it { should validate_presence_of :price }
  it { should validate_presence_of :quality }
end
