# frozen_string_literal: true

# == Schema Information
#
# Table name: topics
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Topic < ApplicationRecord
end
