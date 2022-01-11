# frozen_string_literal: true

module Articles
  module Normalizers
    class Dev
      # {
      #   'title' => Faker::Book.title,
      #   'description' => Faker::Lorem.paragraph,
      #   'url' => Faker::Internet.url,
      #   'comments_count' => rand(10),
      #   'published_timestamp' => Faker::Time.backward.to_s,
      #   'social_image' => Faker::Avatar.image,
      #   'created_at' => Faker::Time.backward.to_s,
      #   'edited_at' => Faker::Time.backward.to_s,
      #   'published_at' => Faker::Time.backward.to_s,
      #   'reading_time_minutes' => rand(10),
      #   'tag_list' => rand(3).times.map { Faker::ProgrammingLanguage.name },
      #   'user' => {
      #     'name' => Faker::Name.name,
      #     'username' => Faker::Internet.username,
      #     'twitter_username' => Faker::Internet.username,
      #     'github_username' => Faker::Internet.username,
      #     'website_url' => Faker::Internet.url,
      #     'profile_image' => Faker::Avatar.image
      #   },
      #   'organization' => {
      #     'name' => Faker::Company.name,
      #     'username' => Faker::Internet.username,
      #     'profile_image' => Faker::Avatar.image
      #   }
      # }
      def article_attributes(article)
        {
          remote_id: article['id'],
          title: article['title'],
          description: article['description'],
          url: article['url'],
          image: article['social_image'],
          published_at: article['published_at'].to_time,
          author: author_attributes(article['user']),
          tags: article['tag_list']
        }
      end

      def author_attributes(user)
        {
          name: user['name'],
          username: user['username'],
          profile_image_url: user['profile_image']
        }
      end
    end
  end
end
