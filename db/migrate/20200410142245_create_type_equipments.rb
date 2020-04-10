class CreateTypeEquipments < ActiveRecord::Migration[5.2]
  def change
    create_table :type_equipments do |t|
      t.string :name

      t.timestamps
    end
  end
end
