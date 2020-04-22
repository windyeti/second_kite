require 'rails_helper'

RSpec.describe AdKite, type: :model do
  it { should belong_to :ad }
  it { should belong_to :kite }
end
