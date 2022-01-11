# frozen_string_literal: true

namespace :articles do
  desc 'schedule Articles::PullJob for all the platforms'
  task schedule_pull: :environment do
    Platform.find_each do |platform|
      Articles::PullJob.perform_later(platform:, page: 1, per_page: 100, max_pages: 10)
    end
  end
end
