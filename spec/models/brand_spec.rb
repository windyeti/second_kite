require 'rails_helper'

RSpec.describe Brand, type: :model do
  it { should validate_presence_of :name }

  it { should have_many(:brand_type_equipments).dependent(:destroy) }
  it { should have_many(:type_equipments).through(:brand_type_equipments) }
end
