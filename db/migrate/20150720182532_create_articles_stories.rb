class CreateArticlesStories < ActiveRecord::Migration
  def change
    create_table :articles_stories do |t|
      t.references :article
      t.references :story
      t.timestamps
    end
  end
end
