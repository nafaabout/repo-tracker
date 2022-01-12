class RenameBlogArticleToArticleOnAllTables < ActiveRecord::Migration[7.0]
  def change
    rename_column :blog_article_topics, :blog_article_id, :article_id
    rename_table :blog_article_topics, :article_topics

    rename_column :tag_articles, :blog_article_id, :article_id

    rename_table :blog_articles, :articles
  end
end
