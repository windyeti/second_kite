class AddApproveToKiteName < ActiveRecord::Migration[5.2]
  def change
    add_column :kite_names, :approve, :boolean, default: false
  end
end
