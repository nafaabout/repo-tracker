class CreateTagArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :tag_articles, id: :uuid do |t|
      t.belongs_to :tag, null: false, foreign_key: true, type: :uuid
      t.belongs_to :blog_article, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
