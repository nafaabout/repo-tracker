# frozen_string_literal: true

module Articles
  class Creator
    attr_reader :platform

    def initialize(platform)
      @platform = platform
    end

    def create_article(attributes:)
      platform_id = platform.id
      return if BlogArticle.exists?(platform_id:, remote_id: attributes['id'])

      attributes = normalizer.article_attributes(attributes)
      attributes[:platform_id] = platform_id
      tags = attributes.delete(:tags)
      article = BlogArticle.create(attributes)
      tag_article_with(article, tags)
    end

    private

    def normalizer
      @normalizer ||= Articles::Normalizers.const_get(platform.name.camelize).new
    end

    def tag_article_with(article, tags)
      article.tags = Tag.where(name: tags)
    end
  end
end
