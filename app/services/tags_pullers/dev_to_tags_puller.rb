# frozen_string_literal: true

module TagsPullers
  class DevToTagsPuller
    DEV_TO_API_URI = 'https://dev.to/api'

    class << self
      def pull(page: 1, per_page: 10)
        page = http_conn.get('tags', { page: page, per_page: per_page })

        tags = JSON.parse(page.body)
        yield tags if block_given?

        tags
      end

      private

      def http_conn
        @http_conn ||= Faraday.new(url: DEV_TO_API_URI,
                                   headers: { 'Accept' => 'application/json' })
      end
    end
  end
end
