class AddImgLinkToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :img_link, :string
  end
end
