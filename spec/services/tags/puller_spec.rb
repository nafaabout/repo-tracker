require 'rails_helper'

RSpec.describe Tags::Puller, type: :service do
  subject(:tags_puller) { Tags::Puller.new(platform.name) }

  let!(:platform) { Fabricate(:platform, name: 'Dev') }

  specify { expect(tags_puller.tags_puller).to be_a(Tags::Pullers::DevTo) }

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
