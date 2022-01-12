# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Articles::Creator, type: :service do
  subject(:creator) { described_class.new(platform) }

  let!(:platform) { Fabricate(:platform, name: 'Dev', api_url: 'https://dev.to/api/') }

  describe '#create_article' do
    let(:attributes) { generate_article_attributes }

    it 'creates new article' do
      expect { creator.create_article(attributes:) }.to change(platform.articles, :count).by(1)
    end
  end
end
