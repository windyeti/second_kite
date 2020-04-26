class CreateAdBoards < ActiveRecord::Migration[5.2]
  def change
    create_table :ad_boards do |t|
      t.references :ad, foreign_key: true
      t.references :board, foreign_key: true

      t.timestamps
    end
  end
end
