# frozen_string_literal: true

namespace :tags do
  desc 'schedule Tags::PullJob for all the platforms'
  task schedule_pull: :environment do
    Platform.find_each do |platform|
      Tags::PullJob.perform_later(platform: platform, page: 1, per_page: 1000)
    end
  end
end
