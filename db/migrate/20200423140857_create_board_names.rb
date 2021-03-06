class CreateBoardNames < ActiveRecord::Migration[5.2]
  def change
    create_table :board_names do |t|
      t.references :brand, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
