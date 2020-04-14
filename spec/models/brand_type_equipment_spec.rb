require 'rails_helper'

RSpec.describe BrandTypeEquipment, type: :model do
  it { should belong_to :brand }
  it { should belong_to :type_equipment }
end
