class AddSinglySaleToKites < ActiveRecord::Migration[5.2]
  def change
    add_column :kites, :singly_sale, :boolean, default: true
  end
end
