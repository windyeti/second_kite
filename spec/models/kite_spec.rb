require 'rails_helper'

RSpec.describe Kite, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :total_price }

  it { should belong_to :user }
end
