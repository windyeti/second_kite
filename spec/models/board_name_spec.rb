require 'rails_helper'

RSpec.describe BoardName, type: :model do
  it { should belong_to :brand }

  it { should have_many :boards }

  it_behaves_like "Subscriptionable"

  it { should validate_presence_of :name }


end
