require 'rails_helper'

RSpec.describe Topic, type: :model do
  it { should belong_to(:category) }
  it { should have_many(:user_topics).dependent(:destroy) }
  it { should have_many(:blog_article_topics).dependent(:destroy) }
  it { should have_many(:blog_articles).through(:blog_article_topics) }
end
