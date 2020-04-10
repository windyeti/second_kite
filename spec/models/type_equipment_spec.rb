require 'rails_helper'

RSpec.describe TypeEquipment, type: :model do
  it { should validate_presence_of :name }

  it { should have_many(:brand_type_equipment).dependent(:destroy) }
  it { should have_many(:brand).through(:brand_type_equipment) }
end
