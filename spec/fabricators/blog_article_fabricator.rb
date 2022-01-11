# frozen_string_literal: true

# == Schema Information
#
# Table name: blog_articles
#
#  id           :uuid             not null, primary key
#  author       :jsonb
#  published_at :datetime
#  title        :string
#  url          :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  platform_id  :uuid             not null
#  remote_id    :integer
#
# Indexes
#
#  index_blog_articles_on_platform_id  (platform_id)
#
# Foreign Keys
#
#  fk_rails_...  (platform_id => platforms.id)
#
Fabricator(:blog_article) do
  title        { Faker::Lorem.sentence }
  url          { Faker::Internet.url(host: 'dev.to') }
  published_at { Faker::Date.backward }
  platform     { Fabricate(:platform, name: 'Dev') }
  author       { { name: Faker::Name.name } }
  remote_id { rand(1..100) }
end
