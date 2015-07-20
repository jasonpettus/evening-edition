class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :feed
      t.references :Section
      t.string :name
      t.timestamps
    end
  end
end
