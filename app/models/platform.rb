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
  has_many :blog_articles
end
