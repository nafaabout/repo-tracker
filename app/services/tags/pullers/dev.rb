# frozen_string_literal: true

module Tags
  module Pullers
    class Dev
      API_URI = 'https://dev.to/api/tags'

      def pull(page: 1, per_page: 10)
        Rails.logger.info("Tags: Dev => page: #{page}, per page: #{per_page} tag")
        page = Faraday.get(API_URI, { page:, per_page: })
        tags = JSON.parse(page.body)
        @more_tags = tags.size == per_page
        tags
      end

      def more_tags?
        !!@more_tags
      end
    end
  end
end
