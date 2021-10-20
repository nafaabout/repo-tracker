# frozen_string_literal: true

class TagsPuller
  attr_reader :platform

  def initialize(platform)
    @platform = platform
  end

  def pull(page: 1, per_page: 10, &block)
    tags_puller_class.pull(page: page, per_page: per_page, &block)
  end

  private

  def tags_puller_class
    @tags_puller_class ||= "tags_pullers/#{platform}_tags_puller".gsub('.', '_')
                                                                 .camelize.constantize
  end
end
