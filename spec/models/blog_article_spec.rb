require 'rails_helper'

RSpec.describe BlogArticle, type: :model do
  it { should belong_to(:platform) }
  it { should have_many(:blog_article_topics) }
  it { should have_many(:topics).through(:blog_article_topics) }
end
