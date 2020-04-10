class CreateBrandTypeEquipments < ActiveRecord::Migration[5.2]
  def change
    create_table :brand_type_equipments do |t|
      t.references :brand, foreign_key: true
      t.references :type_equipment, foreign_key: true

      t.timestamps
    end
  end
end
