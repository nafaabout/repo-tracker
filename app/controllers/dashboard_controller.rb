# frozen_string_literal: true

class DashboardController < ApplicationController
  include Authenticated

  def show
    @blog_articles = BlogArticle.order(:updated_at).first(10)
  end
end
