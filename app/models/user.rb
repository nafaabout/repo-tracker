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
  has_many :user_tags, dependent: :destroy

  def following_tag?(tag)
    user_tags.exists?(tag:)
  end

  def toggle_follow_tag!(tag)
    user_tag = user_tags.find_by(tag:)
    if user_tag.present?
      unfollow_tag!(tag)
    else
      follow_tag!(tag)
    end
  end

  private

  def follow_tag!(tag)
    user_tags.create(tag:)
  end

  def unfollow_tag!(tag)
    user_tags.where(tag:).destroy_all
  end
end
