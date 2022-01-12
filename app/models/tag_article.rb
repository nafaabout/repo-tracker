# frozen_string_literal: true

class TagArticle < ApplicationRecord
  belongs_to :tag
  belongs_to :article
end
