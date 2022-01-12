# frozen_string_literal: true

# == Schema Information
#
# Table name: article_topics
#
#  id              :uuid             not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  article_id :uuid             not null
#  topic_id        :uuid             not null
#
# Indexes
#
#  index_article_topics_on_article_id  (article_id)
#  index_article_topics_on_topic_id         (topic_id)
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#  fk_rails_...  (topic_id => topics.id)
#
class ArticleTopic < ApplicationRecord
  belongs_to :article
  belongs_to :topic
end
