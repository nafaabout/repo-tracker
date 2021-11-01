# frozen_string_literal: true

module Tags
  class PullJob < ApplicationJob
    queue_as :tags_pull

    def perform(platform:, page: 1, per_page: 10)
      tags_puller = Tags::Puller.new(platform.name)

      tags = tags_puller.pull(page: page, per_page: per_page)

      tags.each do |tag|
        tag = Tag.find_or_create_by(name: tag['name'])
        tag.add_platform(platform)
      end

      return unless tags_puller.more_tags?

      PullJob.perform_later(platform: platform,
                            page: page.next,
                            per_page: per_page)
    end
  end
end
