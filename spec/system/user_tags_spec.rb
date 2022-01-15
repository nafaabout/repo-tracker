require 'rails_helper'

RSpec.describe 'User Tags', type: :system do
  let(:uid) { OmniAuth.config.mock_auth[:auth0]['uid'] }
  let!(:user) { User.find_by uid: }
  let!(:tags) { Fabricate.times(tags_count, :tag) }
  let(:tags_count) { 5 }

  before(:all) do
    driven_by :selenium
  end

  before do
    auth0_login
  end

  context 'First load' do
    let(:tags_count) { 21 }

    it 'shows the first 20 tags only' do
      visit settings_tags_path

      expect(page).to have_selector('.tag', count: 20)
      Tag.order(name: :asc).first(20).each do |tag|
        expect(page).to have_selector(".tag##{dom_id(tag)}", text: tag.name)
      end
    end
  end

  context 'Searching tags' do
    let(:tags_count) { 25 }
    let(:filter) { tags.first.name[0, 3] }
    let(:matched_tags) { tags.select{ _1.name.starts_with?(filter) } }
    let(:rejected_tags) { tags.select{ !_1.name.starts_with?(filter) } }

    it 'allows user to search for tags', :js do
      visit settings_tags_path

      fill_in 'filter_term', with: filter

      expect(page).to have_selector('.tag', count: matched_tags.size)
      matched_tags[0...20].each do |tag|
        expect(page).to have_selector("##{dom_id(tag)}", text: tag.name)
      end

      rejected_tags.each do |tag|
        expect(page).to_not have_selector(".tag##{dom_id(tag)}", text: tag.name)
      end
    end

    context 'When more than 20 matching tags' do
      let(:filter) { 'rub' }
      let!(:tags) { Fabricate.times(tags_count, :tag, name: 'ruby') }

      it 'loads only the first 20 matching tags' do
        visit settings_tags_path

        fill_in 'filter_term', with: filter

        expect(page).to have_selector('.tag', text: 'ruby', count: 20)
      end

      context 'When clicking "Load more"' do
        it 'loads the next 20 tags'
      end
    end

    context 'When there are <= 20 matching tags' do
      it 'does not show "Load more"'
    end
  end

  it 'enables user to follow tags', :js do
    visit settings_tags_path

    tags_to_follow = tags.sample(2)

    tags_to_follow.each do |tag|
      click_on(tag.name)
      expect(page).to have_css("##{dom_id(tag)} .followed")
    end
  end
end
