require 'rails_helper'

RSpec.describe Tags::Puller, type: :service do
  subject(:tags_puller) { described_class.new(platform.name) }

  let!(:platform) { Fabricate(:platform, name: 'Dev') }

  specify { expect(tags_puller.tags_puller).to be_a(Tags::Pullers::Dev) }

  describe '.puller_class_for' do
    it 'returns the class Tags::Pullers::{platform_name}' do
      expect(described_class.puller_class_for('dev')).to be(Tags::Pullers::Dev)
      expect(described_class.puller_class_for(platform)).to be(Tags::Pullers::Dev)
    end
  end

  describe '.puller_for' do
    it 'returns an instance of the puller_class of the platform' do
      expect(described_class.puller_for(platform)).to be_a(Tags::Pullers::Dev)
    end
  end

  describe '.api_url_for' do
    it 'returns the API_URI of the platform puller class' do
      expect(described_class.api_url_for(platform)).to eq(Tags::Puller.puller_class_for(platform)::API_URI)
    end
  end

  describe '#more_tags?' do
    it 'delegates to platform #more_tags?' do
      expect(tags_puller.tags_puller).to receive(:more_tags?)

      tags_puller.more_tags?
    end
  end

  describe '#pull' do
    it 'redirects the pull to the tags puller of the platform' do
      expect(tags_puller.tags_puller).to receive(:pull)
      tags_puller.pull
    end
  end
end
