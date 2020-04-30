class CreateStuffs < ActiveRecord::Migration[5.2]
  def change
    create_table :stuffs do |t|
      t.references :user, foreign_key: true
      t.references :stuff_name, foreign_key: true
      t.integer :price, null: false
      t.integer :quality, null: false
      t.integer :year
      t.text :description
      t.boolean :singly_sale, default: true

      t.timestamps
    end
  end
end
