class AddDescriptionImageToBlogArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :blog_articles, :description, :string
    add_column :blog_articles, :image, :string
  end
end
