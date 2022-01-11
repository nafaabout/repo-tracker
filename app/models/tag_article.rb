# frozen_string_literal: true

class TagArticle < ApplicationRecord
  belongs_to :tag
  belongs_to :blog_article
end
