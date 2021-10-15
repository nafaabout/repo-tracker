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
Fabricator(:platform_with_no_tag, class_name: :platform) do
  name     { Faker::Company.name }
  base_url { Faker::Internet.url path: nil }
  api_url  { |attrs| "#{attrs[:base_url]}/api" }
  category { Faker::Company.industry }
end

Fabricator(:platform, from: :platform_with_no_tag) do
  tag_platforms(rand: 5)
end
