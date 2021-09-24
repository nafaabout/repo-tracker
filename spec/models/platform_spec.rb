require 'rails_helper'

RSpec.describe Platform, type: :model do
  it { should have_many(:blog_articles) }
end
