# frozen_string_literal: true

class DashboardController < ApplicationController
  include Authenticated

  def show
    @articles = Article.order(:updated_at).first(10)
  end
end
