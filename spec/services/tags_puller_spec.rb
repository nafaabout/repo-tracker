require 'rails_helper'

RSpec.describe TagsPuller, type: :service do
  subject(:tags_puller) { TagsPuller.new(platform.name) }

  let!(:platform) { Fabricate(:platform, name: 'Dev.to') }

  describe '#pull' do
    it 'redirects the pull to the tags puller of the platform' do
      expect(TagsPullers::DevToTagsPuller).to receive(:pull)
      tags_puller.pull
    end
  end
end
