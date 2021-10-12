require 'rails_helper'

RSpec.describe Platform, type: :model do
  it { should have_many(:blog_articles) }
  it { should have_many(:tag_platforms).dependent(:destroy) }
  it { should have_many(:tags).through(:tag_platforms) }
end
