require 'rails_helper'

RSpec.describe User, type: :model do
  subject!(:user) { Fabricate(:user) }

  it { should have_many(:user_tags).dependent(:destroy) }

  describe '#following_tag?' do
    let!(:tag) { Fabricate(:tag) }

    context 'when user is not following tag' do
      before do
        UserTag.destroy_all
      end

      it 'returns false' do
        expect(user.following_tag?(tag)).to be false
      end
    end

    context 'when user is following tag' do
      before do
        UserTag.create(user:, tag:)
      end

      it 'returns true' do
        expect(user.following_tag?(tag)).to eq true
      end
    end
  end

  describe '#toggle_follow_tag!' do
    let!(:tag) { Fabricate(:tag) }

    context 'when user is following tag' do
      it 'unfollows tag' do
        user.user_tags.create(tag:)
        expect { user.toggle_follow_tag!(tag) }.to change { user.following_tag?(tag) }.to(false)
      end
    end

    context 'when user is not following tag' do
      it 'follows tag' do
        user.user_tags.destroy_all
        expect { user.toggle_follow_tag!(tag) }.to change { user.following_tag?(tag) }.to(true)
      end
    end
  end
end
