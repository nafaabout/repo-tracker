require 'rails_helper'

module Tags
  module Pullers
    RSpec.describe Dev, type: :service do
      subject(:tags_puller) { described_class.new }

      specify { expect(described_class::API_URI).to eq('https://dev.to/api/tags') }

      describe '#more_tags?' do
        let(:tags) { generate_tags_response_body(response_tags_count) }
        let(:page) { 1 }
        let(:per_page) { 5 }

        before do
          stub_tags_request(tags:, query: { per_page: })
        end

        context 'when pulled tags count == per_page' do
          let(:response_tags_count) { per_page }

          it 'returns false' do
            tags_puller.pull(page:, per_page:)
            expect(tags_puller.more_tags?).to eq true
          end
        end

        context 'when pulled tags count < per_page' do
          let(:response_tags_count) { per_page - 1 }

          it 'returns false' do
            tags_puller.pull(page:, per_page:)
            expect(tags_puller.more_tags?).to eq false
          end
        end
      end

      describe '#pull' do
        let(:tags) { generate_tags_response_body(3) }
        let(:api_url) { described_class::API_URI }
        let(:query) { { page: 1, per_page: 10 } }

        before do
          stub_tags_request(tags:, query:)
        end

        it 'calls dev api tags endpoint' do
          tags_puller.pull

          expect(a_request(:get, api_url)
            .with(query:)).to have_been_made.once
        end

        it 'returns an array of tags' do
          expect(tags_puller.pull).to eq(tags)
        end

        context 'when no params specified' do
          it 'defaults to page: 1 and per_page: 10' do
            tags_puller.pull

            expect(a_request(:get, api_url)
              .with(query:)).to have_been_made.once
          end
        end

        context 'when params specified' do
          let(:query) { { page: 2, per_page: 100 } }

          it 'calls the api with the specified args' do
            tags_puller.pull(page: query[:page], per_page: query[:per_page])

            expect(a_request(:get, api_url)
              .with(query:)).to have_been_made.once
          end
        end
      end
    end
  end
end
