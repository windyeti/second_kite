class CreateStuffNames < ActiveRecord::Migration[5.2]
  def change
    create_table :stuff_names do |t|
      t.references :brand, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
