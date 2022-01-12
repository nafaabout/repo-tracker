# frozen_string_literal: true

module Settings
  class TagsController < ApplicationController
    include Authenticated

    def index
      @tags = Tag.all
    end

    def follow
      tag = Tag.find(params[:id])
      current_user.toggle_follow_tag!(tag)
      render partial: 'tag', locals: { tag: }
    end

    def update; end
  end
end
