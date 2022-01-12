require 'rails_helper'

RSpec.describe 'Dashboard Articles', type: :system do
  before(:all) do
    driven_by(:selenium)
  end

  context 'when user not logged in' do
    it 'redirect to root path' do
      visit dashboard_path

      expect(page).to have_content('Login please')
    end
  end

  context 'when user is logged in' do
    let!(:user) { Fabricate(:user) }
    let!(:user_topics) { Fabricate.times(3, :user_topic) }
    let!(:topics) { user_topics.map(&:topic) }
    let!(:platforms) { Fabricate.times(2, :platform) }
    let!(:article_topics) do
      articles.map { |ba| Fabricate(:article_topic, topic: topics.sample, article: ba) }
    end
    let!(:articles) { 11.times.map { Fabricate(:article, platform: platforms.sample) } }

    before do
      mock_auth0_login
    end

    it 'shows latest 10 articles about the selected user topics' do
      visit dashboard_path

      expect(page).to have_selector('.card#articles', text: 'Articles')
      articles.first(10).each do |article|
        expect(page).to have_selector('.card#articles a.article', text: article.title)
      end
    end
  end
end
