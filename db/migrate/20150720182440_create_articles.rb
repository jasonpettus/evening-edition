class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :summary
      t.string :url
      t.string :last_modified
      t.references :subscription
      t.string :img_link
      t.timestamps
    end
  end
end
