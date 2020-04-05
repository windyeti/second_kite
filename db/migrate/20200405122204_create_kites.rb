class CreateKites < ActiveRecord::Migration[5.2]
  def change
    create_table :kites do |t|
      t.string :title
      t.float :total_price
      t.integer :year

      t.timestamps
    end
  end
end
