class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :size
      t.references :user
      t.references :preferred_story
      t.timestamps
    end
  end
end
