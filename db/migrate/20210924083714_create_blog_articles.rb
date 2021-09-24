class CreateBlogArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :blog_articles, id: :uuid do |t|
      t.string :title
      t.string :url
      t.datetime :published_at
      t.belongs_to :platform, null: false, foreign_key: true, type: :uuid
      t.jsonb :author
      t.integer :remote_id

      t.timestamps
    end
  end
end
