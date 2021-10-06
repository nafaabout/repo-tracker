require 'rails_helper'

RSpec.describe 'Dashboard Blog Articles', type: :system do
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
    let!(:blog_article_topics) do
      blog_articles.map { |ba| Fabricate(:blog_article_topic, topic: topics.sample, blog_article: ba) }
    end
    let!(:blog_articles) { 11.times.map { Fabricate(:blog_article, platform: platforms.sample) } }

    before do
      mock_auth0_login
    end

    it 'shows latest 10 blog articles about the selected user topics' do
      visit dashboard_path

      expect(page).to have_selector('.card#blog_articles', text: 'Blog Articles')
      blog_articles.first(10).each do |article|
        expect(page).to have_selector('.card#blog_articles a.blog_article', text: article.title)
      end
    end
  end
end
