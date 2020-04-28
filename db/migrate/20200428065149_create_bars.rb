class CreateBars < ActiveRecord::Migration[5.2]
  def change
    create_table :bars do |t|
      t.references :user, foreign_key: true
      t.references :bar_name, foreign_key: true
      t.integer :length, null: false
      t.integer :year, null: false
      t.integer :price, null: false
      t.integer :quality, null: false
      t.boolean :singly_sale, default: true

      t.timestamps
    end
  end
end
