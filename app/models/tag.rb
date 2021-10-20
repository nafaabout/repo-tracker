# frozen_string_literal: true

# == Schema Information
#
# Table name: tags
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tag < ApplicationRecord
  has_many :tag_platforms, dependent: :destroy
  has_many :platforms, through: :tag_platforms

  def add_platform(platform)
    return if exists_on?(platform)

    tag_platforms.create(platform: platform)
  end

  def exists_on?(platform)
    tag_platforms.exists?(platform: platform)
  end
end
