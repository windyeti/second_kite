require 'rails_helper'

RSpec.describe KiteName, type: :model do
  it { should belong_to :brand }

  it { should have_many :kites }

  it_behaves_like "Subscriptionable"

  it { should validate_presence_of :name }
end
