require 'rails_helper'

RSpec.describe Tags::Pullers::DevTo, type: :service do
  subject(:tags_puller) { described_class.new }

  describe '.pull' do
    let(:tags) { generate_tags_response_body(3) }
    let(:api_url) { described_class::API_URI }
    let(:query) { { page: 1, per_page: 10 } }

    before do
      stub_tags_request(tags: tags, query: query)
    end

    it 'calls dev api tags endpoint' do
      tags_puller.pull

      expect(a_request(:get, api_url)
        .with(query: query)).to have_been_made.once
    end

    it 'returns an array of tags' do
      expect(tags_puller.pull).to eq(tags)
    end

    it 'yields tags if passed a block' do
      expect { |b| tags_puller.pull(&b) }.to yield_with_args(tags)
    end

    context 'when no params specified' do
      it 'defaults to page: 1 and per_page: 10' do
        tags_puller.pull

        expect(a_request(:get, api_url)
          .with(query: query)).to have_been_made.once
      end
    end

    context 'when params specified' do
      let(:query) { { page: 2, per_page: 100 } }

      it 'calls the api with the specified args' do
        tags_puller.pull(page: query[:page], per_page: query[:per_page])

        expect(a_request(:get, api_url)
          .with(query: query)).to have_been_made.once
      end
    end
  end
end
