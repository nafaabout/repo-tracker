require 'rails_helper'

RSpec.describe PullTagsJob, type: :job do
  let(:dev_to_tags_api_url) { 'https://dev.to/api/tags' }
  let!(:platform) { Fabricate(:platform_with_no_tag, name: 'Dev.to') }
  let(:tags_puller) { Tags::Puller.new(platform.name) }

  before do
    allow(Tags::Puller).to receive(:new).with(platform.name).and_return(tags_puller)
  end

  context 'when no arguments provided for page and per_page' do
    let(:tags) { generate_tags_response_body(10) }

    it 'pulls 10 tags from page 1' do
      expect(tags_puller).to receive(:pull)
        .with(page: 1, per_page: 10)

      PullTagsJob.perform_now(platform: platform)
    end

    it 'pulls tags from the given platform' do
      stub_tags_request(tags: tags)

      expect do
        PullTagsJob.perform_now(platform: platform)
      end.to change { Tag.count }.to(tags.count)
    end
  end

  context 'if page and per_page given' do
    let(:page) { rand(10) }
    let(:per_page) { rand(20) }

    it 'pulls that specific tags page from the given platform' do
      expect(tags_puller).to receive(:pull)
        .with(page: page, per_page: per_page)

      PullTagsJob.perform_now(platform: platform, page: page, per_page: per_page)
    end
  end
end
