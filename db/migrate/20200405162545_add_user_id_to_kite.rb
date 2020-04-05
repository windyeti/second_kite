class AddUserIdToKite < ActiveRecord::Migration[5.2]
  def change
    add_reference :kites, :user, foreign_key: true
  end
end
