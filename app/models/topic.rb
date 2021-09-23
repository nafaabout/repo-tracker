# frozen_string_literal: true

# == Schema Information
#
# Table name: topics
#
#  id          :uuid             not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :uuid
#
# Indexes
#
#  index_topics_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#
class Topic < ApplicationRecord
  belongs_to :category
  has_many :user_topics, dependent: :destroy
end
