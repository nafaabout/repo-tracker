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
Fabricator(:platform, class_name: :platform) do
  name     { Faker::Company.name }
  base_url { Faker::Internet.url path: nil }
  api_url  { |attrs| "#{attrs[:base_url]}/api" }
  category { Faker::Company.industry }
end

Fabricator(:platform_with_tags, from: :platform) do
  tag_platforms(rand: 5)
end
