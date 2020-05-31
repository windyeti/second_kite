class AddApproveToBoardName < ActiveRecord::Migration[5.2]
  def change
    add_column :board_names, :approve, :boolean, default: false
    add_column :bar_names, :approve, :boolean, default: false
    add_column :stuff_names, :approve, :boolean, default: false
  end
end
