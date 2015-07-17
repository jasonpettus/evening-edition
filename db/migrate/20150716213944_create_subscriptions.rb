class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
    	t.string			:feed_url
    	t.string			:url
    	t.references	:section

    	t.timestamps
    end
  end
end
