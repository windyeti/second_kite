require 'rails_helper'

RSpec.describe AdBar, type: :model do
  it { should belong_to :ad }
  it { should belong_to :bar }
end
