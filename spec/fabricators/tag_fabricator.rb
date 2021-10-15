# == Schema Information
#
# Table name: tags
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
Fabricator(:tag_with_no_platform, class_name: :tag) do
  name { Faker::Book.genre }
end

Fabricator(:tag, from: :tag_with_no_platform) do
  tag_platforms(rand: 3)
end
