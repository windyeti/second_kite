class AddApproveToAds < ActiveRecord::Migration[5.2]
  def change
    add_column :ads, :approve, :boolean, default: false
  end
end
