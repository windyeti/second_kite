class CreateAds < ActiveRecord::Migration[5.2]
  def change
    create_table :ads do |t|
      t.string :title, null: false
      t.text :description
      t.integer :total_price, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
