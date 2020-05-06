require 'rails_helper'

RSpec.describe BarName, type: :model do
  it { should belong_to :brand }

  it { should have_many(:bars).dependent(:destroy) }

  it_behaves_like "Subscriptionable"

  it { should validate_presence_of :name }
end
