require 'rails_helper'

RSpec.describe 'User Topics', type: :system do
  let(:uid) { OmniAuth.config.mock_auth[:auth0]['uid'] }
  let!(:user) { User.find_by uid: uid }
  let!(:categories) { Fabricate.times(2, :category) }
  let!(:topics) { categories.map { |category| Fabricate.times(2, :topic, category: category) }.flatten }

  before(:all) do
    driven_by(:selenium)
  end

  before do
    auth0_login
  end

  it 'enables user to follow topics', :js do
    visit settings_topics_path

    topics_to_follow = topics.sample(2)

    topics_to_follow.each do |topic|
      click_on(topic.name)
    end

    topics_to_follow.each do |topic|
      expect(page).to have_css("##{dom_id(topic)} .followed")
    end
  end

  it 'groups topics into categories' do
    visit settings_topics_path

    categories.each do |category|
      category_section = page.find(".topics ##{dom_id(category)}")
      expect(category_section).to have_text(category.name)
      category.topics.each do |topic|
        expect(page).to have_css(".topics ##{dom_id(category)} turbo-frame##{dom_id(topic)}", text: topic.name)
      end
    end
  end
end
