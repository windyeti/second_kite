require 'rails_helper'

RSpec.describe TypeEquipment, type: :model do
  it { should validate_presence_of :name }

  it { should have_many(:brand_type_equipments).dependent(:destroy) }
  it { should have_many(:brands).through(:brand_type_equipments) }
end
