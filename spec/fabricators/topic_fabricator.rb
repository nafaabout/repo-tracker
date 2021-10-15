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
Fabricator(:topic_with_no_category, class_name: :topic) do
  name { Faker::ProgrammingLanguage.name }
end

Fabricator(:topic, from: :topic_with_no_category) do
  category
end
