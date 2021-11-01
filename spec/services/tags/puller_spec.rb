require 'rails_helper'

RSpec.describe Tags::Puller, type: :service do
  subject(:tags_puller) { Tags::Puller.new(platform.name) }

  let!(:platform) { Fabricate(:platform, name: 'Dev.to') }

  specify { expect(tags_puller.tags_puller).to be_a(Tags::Pullers::DevTo) }

  describe '#pull' do
    it 'redirects the pull to the tags puller of the platform' do
      expect(tags_puller.tags_puller).to receive(:pull)
      tags_puller.pull
    end
  end
end
