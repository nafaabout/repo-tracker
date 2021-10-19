require 'rails_helper'

RSpec.describe TagsPullers::DevToTagsPuller, type: :service do
  describe '.pull' do
    let(:query) { { page: 1, per_page: 10 } }
    let(:tags) { generate_tags_response_body(3) }
    let(:dev_to_tags_api_url) { 'https://dev.to/api/tags' }

    before do
      stub_request(:get, dev_to_tags_api_url)
        .with(query: query)
        .to_return(status: 200, body: tags.to_json)
    end

    it 'calls dev api tags endpoint' do
      TagsPullers::DevToTagsPuller.pull

      expect(a_request(:get, dev_to_tags_api_url).with(query: query)).to have_been_made.once
    end

    it 'returns an array of tags' do
      expect(TagsPullers::DevToTagsPuller.pull).to eq(tags)
    end

    context 'when no params specified' do
      it 'defaults to page: 1 and per_page: 10'
    end

    context 'when params specified' do
      it 'calls the api with the specified args'
    end
  end
end
