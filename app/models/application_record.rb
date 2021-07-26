# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  before_create :set_id

  private

  def set_id
    self.id = ULID.generate.to_s
  end
end
