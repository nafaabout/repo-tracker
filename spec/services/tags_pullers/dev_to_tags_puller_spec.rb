require 'rails_helper'

RSpec.describe TagsPullers::DevToTagsPuller, type: :service do
  describe '.pull' do
    let(:tags) { generate_tags_response_body(3) }
    let(:dev_to_tags_api_url) { 'https://dev.to/api/tags' }
    let(:query) { { page: 1, per_page: 10 } }

    before do
      stub_request(:get, dev_to_tags_api_url)
        .with(query: query)
        .to_return(status: 200, body: tags.to_json)
    end

    it 'calls dev api tags endpoint' do
      TagsPullers::DevToTagsPuller.pull

      expect(a_request(:get, dev_to_tags_api_url)
        .with(query: query)).to have_been_made.once
    end

    it 'returns an array of tags' do
      expect(TagsPullers::DevToTagsPuller.pull).to eq(tags)
    end

    it 'yields tags if passed a block' do
      expect { |b| TagsPullers::DevToTagsPuller.pull(&b) }.to yield_with_args(tags)
    end

    context 'when no params specified' do
      it 'defaults to page: 1 and per_page: 10' do
        TagsPullers::DevToTagsPuller.pull

        expect(a_request(:get, dev_to_tags_api_url)
          .with(query: query)).to have_been_made.once
      end
    end

    context 'when params specified' do
      let(:query) { { page: 2, per_page: 100 } }

      it 'calls the api with the specified args' do
        TagsPullers::DevToTagsPuller.pull(page: query[:page], per_page: query[:per_page])

        expect(a_request(:get, dev_to_tags_api_url)
          .with(query: query)).to have_been_made.once
      end
    end
  end
end
