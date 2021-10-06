require 'rails_helper'

RSpec.describe BlogArticleTopic, type: :model do
  it { should belong_to(:blog_article) }
  it { should belong_to(:topic) }
end
