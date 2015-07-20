class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :size
      t.references :section
      t.references :preferred_story
      t.timestamps
    end
  end
end
