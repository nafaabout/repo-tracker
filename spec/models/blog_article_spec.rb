require 'rails_helper'

RSpec.describe BlogArticle, type: :model do
  it { should belong_to(:platform) }
  it { should have_many(:tag_articles) }
  it { should have_many(:tags).through(:tag_articles) }
end
