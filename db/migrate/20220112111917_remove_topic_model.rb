class RemoveTopicModel < ActiveRecord::Migration[7.0]
  def change
    drop_table :article_topics
    drop_table :user_topics
    drop_table :topics
  end
end
