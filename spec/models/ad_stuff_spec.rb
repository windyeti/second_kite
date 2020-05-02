require 'rails_helper'

RSpec.describe AdStuff, type: :model do
  it { should belong_to :ad }
  it { should belong_to :stuff }
end
