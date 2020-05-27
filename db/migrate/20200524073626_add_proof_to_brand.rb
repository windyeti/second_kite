class AddProofToBrand < ActiveRecord::Migration[5.2]
  def change
    add_column :brands, :approve, :boolean, default: false
  end
end
