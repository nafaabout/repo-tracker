require 'rails_helper'

RSpec.describe PullTagsJob, type: :job do
  let(:tags) { generate_tags_response_body(rand(1..3)) }
  let(:dev_to_tags_api_url) { 'https://dev.to/api/tags' }
  let(:platform) { Fabricate(:platform_with_no_tag, name: 'Dev.to') }

  it 'pulls tags from the given platform' do
    stub_tags_request(tags: tags)

    expect do
      PullTagsJob.perform_now(platform: platform)
    end.to change { Tag.count }.to(tags.count)
  end
end
