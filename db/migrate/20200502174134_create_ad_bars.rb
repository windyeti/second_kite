class CreateAdBars < ActiveRecord::Migration[5.2]
  def change
    create_table :ad_bars do |t|
      t.references :ad, foreign_key: true
      t.references :bar, foreign_key: true

      t.timestamps
    end
  end
end
