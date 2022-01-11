# frozen_string_literal: true

module Articles
  class PullJob < ActiveJob::Base
    queue_as :articles_pull

    def perform(platform:, page: 1, per_page: 10, max_pages: nil)
      puller = Puller.new(platform)
      creator = Articles::Creator.new(platform)

      articles = puller.pull('articles', page:, per_page:)

      articles.each do |article|
        creator.create_article(attributes: article)
      end

      can_pull_more = max_pages.nil? ? puller.have_more? : page < max_pages
      return unless can_pull_more

      PullJob.perform_later(platform:, page: page.next, per_page:, max_pages:)
    end
  end
end
