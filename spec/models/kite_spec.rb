require 'rails_helper'

RSpec.describe Kite, type: :model do
  it { should belong_to :user }
  it { should belong_to :kite_name }

  it { should validate_presence_of :year }
  it { should validate_presence_of :size }
  it { should validate_presence_of :price }
  it { should validate_presence_of :quality }

  it { should validate_numericality_of :year }
  it { should validate_numericality_of :size }
  it { should validate_numericality_of :price }
  it { should validate_numericality_of :quality }

  it { should validate_inclusion_of(:quality).in_range(1..5) }
end
