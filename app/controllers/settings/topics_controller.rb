# frozen_string_literal: true

module Settings
  class TopicsController < ApplicationController
    include Authenticated

    def index
      @topics = Topic.all
    end

    def follow
      topic = Topic.find(params[:id])
      current_user.toggle_follow!(topic)
      render partial: 'topic', locals: { topic: topic }
    end

    def update; end
  end
end
