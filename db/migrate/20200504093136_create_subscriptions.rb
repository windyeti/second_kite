class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.references :user, foreign_key: true
      t.belongs_to :subscriptionable, polymorphic: true, index: {:name => "index_subscription"}

      t.timestamps
    end
  end
end
