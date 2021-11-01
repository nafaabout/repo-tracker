# frozen_string_literal: true

module Tags
  class Puller
    attr_reader :platform

    class << self
      def puller_class_for(platform)
        @pullers_classes ||= {}
        platform = platform.name if platform.is_a?(ActiveRecord::Base)
        @pullers_classes[platform] ||= Tags::Pullers.const_get(platform.camelize)
      end

      def puller_for(platform)
        puller_class_for(platform).new
      end

      def api_url_for(platform)
        puller_class_for(platform)::API_URI
      end
    end

    def initialize(platform)
      @platform = platform
    end

    def pull(page: 1, per_page: 10, &block)
      tags_puller.pull(page: page, per_page: per_page, &block)
    end

    def more_tags?
      tags_puller.more_tags?
    end

    def tags_puller
      @tags_puller ||= self.class.puller_for(platform)
    end
  end
end
