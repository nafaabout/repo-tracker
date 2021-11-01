# frozen_string_literal: true

module Tags
  class Puller
    attr_reader :platform

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
      @tags_puller ||= tags_puller_class.new
    end

    def tags_puller_class
      @tags_puller_class ||= Tags::Pullers.const_get(platform.gsub('.', '_').camelize)
    end
  end
end
