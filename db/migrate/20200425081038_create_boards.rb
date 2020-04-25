class CreateBoards < ActiveRecord::Migration[5.2]
  def change
    create_table :boards do |t|
      t.references :user, foreign_key: true
      t.references :board_name, foreign_key: true
      t.integer :width, null: false
      t.integer :length, null: false
      t.boolean :pads, default: true
      t.boolean :fins, default: true
      t.boolean :singly_sale, default: true
      t.integer :year, null: false
      t.integer :quality, null: false
      t.integer :price, null: false

      t.timestamps
    end
  end
end
