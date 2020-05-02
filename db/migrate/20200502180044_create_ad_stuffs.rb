class CreateAdStuffs < ActiveRecord::Migration[5.2]
  def change
    create_table :ad_stuffs do |t|
      t.references :ad, foreign_key: true
      t.references :stuff, foreign_key: true

      t.timestamps
    end
  end
end
