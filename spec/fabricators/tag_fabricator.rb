# == Schema Information
#
# Table name: tags
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
Fabricator(:tag, class_name: :tag) do
  name { Faker::Book.genre }
end

Fabricator(:tag_with_platform, from: :tag) do
  tag_platforms(rand: 3)
end
