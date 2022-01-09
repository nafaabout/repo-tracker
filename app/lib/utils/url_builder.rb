# frozen_string_literal: true

module Utils
  class UrlBuilder
    class << self
      def api_url_for(platform, resource)
        send(:"#{platform.name.downcase}_url_for", platform.api_url, resource)
      end

      def dev_url_for(api_url, resource)
        URI.join(api_url, resource)
      end
    end
  end
end
