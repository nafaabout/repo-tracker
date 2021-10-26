require 'rails_helper'

RSpec.describe PullTagsJob, type: :job do
  let(:page) { 1 }
  let(:per_page) { 10 }
  let(:tags) { generate_tags_response_body(per_page) }
  let(:dev_to_tags_api_url) { 'https://dev.to/api/tags' }
  let!(:platform) { Fabricate(:platform_with_no_tag, name: 'Dev.to') }
  let(:tags_puller) { Tags::Puller.new(platform.name) }

  before do
    allow(Tags::Puller).to receive(:new).with(platform.name).and_return(tags_puller)
  end

  context 'when no arguments provided for page and per_page' do
    it 'pulls tags from the given platform' do
      stub_tags_request(tags: tags)

      expect(tags_puller).to receive(:pull)
        .with(page: page, per_page: per_page)
        .and_yield(tags)

      expect do
        PullTagsJob.perform_now(platform: platform)
      end.to change { Tag.count }.to(tags.count)
    end
  end

  context 'if page and per_page given' do
    let(:page) { rand(2..10) }
    let(:per_page) { rand(5..20) }

    it 'pulls that specific tags page from the given platform' do
      stub_tags_request(tags: tags, query: { page: page, per_page: per_page })

      expect(tags_puller).to receive(:pull)
        .with(page: page, per_page: per_page)
        .and_yield(tags)

      expect do
        PullTagsJob.perform_now(platform: platform, page: page, per_page: per_page)
      end.to change { Tag.count }.to(per_page)
    end
  end
end
