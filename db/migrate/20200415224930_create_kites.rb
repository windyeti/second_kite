class CreateKites < ActiveRecord::Migration[5.2]
  def change
    create_table :kites do |t|
      t.references :user, foreign_key: true
      t.references :kite_name, foreign_key: true
      t.integer :year, null: false
      t.integer :size, null: false
      t.integer :price, null: false
      t.integer :quality, null: false

      t.timestamps
    end
  end
end
