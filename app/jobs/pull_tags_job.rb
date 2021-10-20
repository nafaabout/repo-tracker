# frozen_string_literal: true

class PullTagsJob < ApplicationJob
  queue_as :pull_tags

  def perform(platform:, page: 1, per_page: 10)
    tags_puller = Tags::Puller.new(platform.name)

    tags_puller.pull(page: page, per_page: per_page) do |tags|
      tags.each do |tag|
        tag = Tag.find_or_initialize_by(name: tag['name'])
        tag.tag_platforms.build(platform: platform) if tag.persisted? && !tag.tag_platforms.exists?(platform: platform)
        tag.save
      end
    end
  end
end
