class AddsFavoritedToStories < ActiveRecord::Migration
  def change
    add_column :stories, :favorited, :boolean, default: false
  end
end
