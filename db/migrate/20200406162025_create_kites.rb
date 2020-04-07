class CreateKites < ActiveRecord::Migration[5.2]
  def change
    create_table :kites do |t|
      t.references :user, foreign_key: true
      t.string :brand, null: false
      t.string :name, null: false
      t.integer :year, null: false
      t.integer :size, null: false
      t.string :type
      t.string :sling_system
      t.integer :length_slim
      t.boolean :one_pump
      t.integer :price, null: false
      t.integer :quality, null: false
      t.string :city
      t.boolean :cargoable
      t.string :origin_site

      t.timestamps
    end
  end
end
