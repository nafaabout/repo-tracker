require 'rails_helper'

RSpec.describe Platform, type: :model do
  it { should have_many(:blog_articles) }
  it { should have_many(:tag_platforms).dependent(:destroy) }
  it { should have_many(:tags).through(:tag_platforms) }

  describe '#create' do
    it 'it adds a slash to the api_url' do
      platform = Fabricate(:platform, api_url: 'https://example.com/api')

      expect(platform.api_url).to end_with '/'
    end
  end
end
