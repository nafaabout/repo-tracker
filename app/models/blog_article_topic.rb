# frozen_string_literal: true

# == Schema Information
#
# Table name: blog_article_topics
#
#  id              :uuid             not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  blog_article_id :uuid             not null
#  topic_id        :uuid             not null
#
# Indexes
#
#  index_blog_article_topics_on_blog_article_id  (blog_article_id)
#  index_blog_article_topics_on_topic_id         (topic_id)
#
# Foreign Keys
#
#  fk_rails_...  (blog_article_id => blog_articles.id)
#  fk_rails_...  (topic_id => topics.id)
#
class BlogArticleTopic < ApplicationRecord
  belongs_to :blog_article
  belongs_to :topic
end
