# frozen_string_literal: true

# == Schema Information
#
# Table name: platforms
#
#  id         :uuid             not null, primary key
#  api_url    :string
#  base_url   :string
#  category   :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Platform < ApplicationRecord
  has_many :articles
  has_many :tag_platforms, dependent: :destroy
  has_many :tags, through: :tag_platforms

  before_save :api_url_ends_with_slash

  private

  def api_url_ends_with_slash
    return if api_url.ends_with?('/')

    self.api_url = "#{api_url}/"
  end
end
