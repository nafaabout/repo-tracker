# frozen_string_literal: true

require 'rails_helper'

module Articles
  RSpec.describe PullJob, type: :job do
    let!(:platform) { Fabricate(:platform, name: 'Dev') }
    let(:puller) { Puller.new(platform) }
    let(:tags) { Fabricate.times(2, :tag).map(&:name) }
    let(:articles) { generate_articles_response_body(per_page, tags:) }

    specify { expect(described_class.queue_name).to eq('articles_pull') }

    before do
      allow(Puller).to receive(:new).and_return(puller)
    end

    context 'when no arguments provided for page and per_page' do
      let(:page) { 1 }
      let(:per_page) { 10 }

      it 'pulls 10 articles from the given platform' do
        expect(puller).to receive(:pull)
          .with('articles', page:, per_page:)
          .and_return(articles)

        expect do
          PullJob.perform_now(platform:)
        end.to change(BlogArticle, :count).to(articles.count)
      end
    end

    context 'when page and per_page arguments are provided' do
      let(:page) { rand(1..10) }
      let(:per_page) { rand 5..10 }

      it 'pulls {per_page} articles from the {page}' do
        expect(puller).to receive(:pull)
          .with('articles', page:, per_page:)
          .and_return(articles)

        PullJob.perform_now(platform:, page:, per_page:)
      end
    end

    context 'When specifying a max number of pages to pull' do
      let(:max_pages) { 5 }
      let(:per_page) { 10 }

      before do
        allow(puller).to receive(:pull)
          .with('articles', page:, per_page:)
          .and_return([])
      end

      context 'and did not reach that limit' do
        let(:page) { 4 }

        it 'schedule new jobs' do
          expect do
            PullJob.perform_now(platform:, page:, per_page:, max_pages:)
          end.to enqueue_job(PullJob)
            .with(platform:, page: page.next, per_page:, max_pages:)
            .exactly(:once)
        end
      end

      context 'and it reached that limit' do
        let(:page) { max_pages }

        it 'stops scheduling new jobs' do
          expect do
            PullJob.perform_now(platform:, page:, per_page:, max_pages:)
          end.to_not enqueue_job(PullJob)
        end
      end
    end
  end
end
