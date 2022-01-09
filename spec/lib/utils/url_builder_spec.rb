require 'rails_helper'

RSpec.describe Utils::UrlBuilder, type: :utils do
  describe '.api_url_for' do
    let!(:platform) { Platform.new(name: 'Dev', api_url: 'https://dev.to/api/') }

    it 'returns the url for the given platform and resource' do
      %w[articles tags].each do |resource|
        expect(described_class.api_url_for(platform, resource)).to eq(URI("https://dev.to/api/#{resource}"))
      end
    end
  end
end
