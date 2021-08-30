# == Schema Information
#
# Table name: user_topics
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  topic_id   :uuid             not null
#  user_id    :uuid             not null
#
# Indexes
#
#  index_user_topics_on_topic_id  (topic_id)
#  index_user_topics_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (topic_id => topics.id)
#  fk_rails_...  (user_id => users.id)
#
class UserTopic < ApplicationRecord
  belongs_to :user
  belongs_to :topic
end
