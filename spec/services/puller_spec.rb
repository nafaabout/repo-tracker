require 'rails_helper'

RSpec.describe Puller, type: :service do
  subject(:puller) { described_class.new(platform) }

  let!(:platform) { Fabricate(:platform, name: 'Dev', api_url: 'https://dev.to/api/') }
  let(:api_url) { puller.api_url('articles') }
  let(:query) { { page:, per_page: } }
  let(:page) { 1 }
  let(:per_page) { 10 }

  describe '#api_url' do
    it 'builds the url for the resource' do
      expect(Utils::UrlBuilder).to receive(:api_url_for).with(platform, 'articles')
      puller.api_url('articles')
    end
  end

  describe '#pull' do
    let(:resources) { generate_response_body(3) }
    let(:response_body) { resources.to_json }

    before do
      stub_api_request(puller:, response_body:, query:)
    end

    it "calls endpoint of the platform's api for the resource" do
      puller.pull('articles')

      expect(a_request(:get, api_url).with(query:)).to have_been_made.once
    end

    it 'returns an array of resources' do
      expect(puller.pull('articles')).to eq(resources)
    end

    context 'when no params specified' do
      it 'defaults to page: 1 and per_page: 10' do
        puller.pull('articles')

        expect(a_request(:get, api_url).with(query:)).to have_been_made.once
      end
    end

    context 'when params specified' do
      let(:query) { { page: 2, per_page: 100 } }

      it 'calls the api with the specified args' do
        puller.pull('articles', page: query[:page], per_page: query[:per_page])

        expect(a_request(:get, api_url).with(query:)).to have_been_made.once
      end
    end
  end

  describe '#have_more?' do
    let(:response_body) { generate_response_body(resources_count).to_json }

    before do
      stub_api_request(puller:, response_body:, query:)
    end

    context 'when pulled resources count == per_page' do
      let(:resources_count) { per_page }

      it 'returns false' do
        puller.pull('articles', page:, per_page:)
        expect(puller.have_more?).to eq true
      end
    end

    context 'when pulled resources count < per_page' do
      let(:resources_count) { per_page - 1 }

      it 'returns false' do
        puller.pull('articles', page:, per_page:)
        expect(puller.have_more?).to eq false
      end
    end
  end
end
