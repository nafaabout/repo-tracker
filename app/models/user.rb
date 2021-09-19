# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :uuid             not null, primary key
#  email      :string
#  image      :string
#  name       :string           not null
#  nickname   :string
#  token      :string           not null
#  token_type :string           not null
#  uid        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  has_many :user_topics

  def following?(topic)
    user_topics.exists?(topic: topic)
  end

  def toggle_follow!(topic)
    user_topic = user_topics.find_by(topic: topic)
    if user_topic.present?
      unfollow_topic!(topic)
    else
      follow_topic!(topic)
    end
  end

  def follow_topic!(topic)
    user_topics.create(topic: topic)
  end

  def unfollow_topic!(topic)
    user_topics.where(topic: topic).destroy_all
  end
end
