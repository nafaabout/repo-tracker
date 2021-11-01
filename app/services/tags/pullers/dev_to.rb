# frozen_string_literal: true

module Tags
  module Pullers
    class DevTo
      API_URI = 'https://dev.to/api/tags'

      def pull(page: 1, per_page: 10)
        page = Faraday.get(API_URI, { page: page, per_page: per_page })

        tags = JSON.parse(page.body)
        yield tags if block_given?

        tags
      end
    end
  end
end
