class CreateAdKites < ActiveRecord::Migration[5.2]
  def change
    create_table :ad_kites do |t|
      t.references :ad, foreign_key: true
      t.references :kite, foreign_key: true

      t.timestamps
    end
  end
end
