require 'rails_helper'

RSpec.describe 'User Topics', type: :system do
  let!(:topics) { Fabricate.times(10, :topic) }
  let(:uid) { OmniAuth.config.mock_auth[:auth0]['uid'] }
  let!(:user) { Fabricate(:user, uid: uid) }

  before do
    driven_by(:selenium)
  end

  it 'enables user to follow topics', js: true do
    visit '/auth/auth0/callback'
    visit settings_topics_path

    topics_to_follow = topics.sample(2)

    topics_to_follow.each do |topic|
      click_on(topic.name)
    end

    topics_to_follow.each do |topic|
      expect(page).to have_css("#topic_#{topic.id} .followed")
    end
  end
end
