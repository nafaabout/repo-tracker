# frozen_string_literal: true

module ArticlesHelpers
  def stub_api_request(puller:, response_body:, query: {})
    query[:page] ||= 1
    query[:per_page] ||= 10
    stub_request(:get, puller.api_url('articles'))
      .with(query:)
      .to_return(status: 200, body: response_body)
  end

  def generate_response_body(count = 3)
    count.times.map do
      {
        'id' => rand(1000),
        'title' => Faker::Book.title,
        'description' => Faker::Lorem.paragraph,
        'url' => Faker::Internet.url
      }
    end
  end

  def generate_articles_response_body(count = 3, tags: nil)
    count.times.map do
      generate_article_attributes(tags:)
    end
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def generate_article_attributes(tags: nil)
    tags ||= Fabricate.times(3, :tag).map(&:name)

    {
      'id' => rand(1000),
      'title' => Faker::Book.title,
      'description' => Faker::Lorem.paragraph,
      'url' => Faker::Internet.url,
      'comments_count' => rand(10),
      'published_timestamp' => Faker::Time.backward.to_s,
      'social_image' => Faker::Avatar.image,
      'created_at' => Faker::Time.backward.to_s,
      'edited_at' => Faker::Time.backward.to_s,
      'published_at' => Faker::Time.backward.to_s,
      'reading_time_minutes' => rand(10),
      'tag_list' => tags,
      'user' => {
        'name' => Faker::Name.name,
        'username' => Faker::Internet.username,
        'twitter_username' => Faker::Internet.username,
        'github_username' => Faker::Internet.username,
        'website_url' => Faker::Internet.url,
        'profile_image' => Faker::Avatar.image
      },
      'organization' => {
        'name' => Faker::Company.name,
        'username' => Faker::Internet.username,
        'profile_image' => Faker::Avatar.image
      }
    }
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
end
