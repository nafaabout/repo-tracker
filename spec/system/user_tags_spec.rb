require 'rails_helper'

RSpec.describe 'User Tags', type: :system do
  let(:uid) { OmniAuth.config.mock_auth[:auth0]['uid'] }
  let!(:user) { User.find_by uid: }
  let!(:tags) { Fabricate.times(5, :tag) }

  before(:all) do
    driven_by(:selenium)
  end

  before do
    auth0_login
  end

  it 'enables user to follow tags', :js do
    visit settings_tags_path

    tags_to_follow = tags.sample(2)

    tags_to_follow.each do |tag|
      click_on(tag.name)
    end

    tags_to_follow.each do |tag|
      expect(page).to have_css("##{dom_id(tag)} .followed")
    end
  end
end
