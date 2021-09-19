require 'rails_helper'

RSpec.describe User, type: :model do
  subject!(:user) { Fabricate(:user) }

  describe '#following?' do
    let!(:topic) { Fabricate(:topic) }

    context 'when user is not following topic' do
      before do
        UserTopic.destroy_all
      end

      it 'returns false' do
        expect(user.following?(topic)).to be false
      end
    end

    context 'when user is following topic' do
      before do
        UserTopic.create(user: user, topic: topic)
      end

      it 'returns true' do
        expect(user.following?(topic)).to eq true
      end
    end
  end

  describe '#follow_topic!' do
    let!(:topic) { Fabricate(:topic) }

    context 'when user is not following topic' do
      it 'sets user to follow topic' do
        expect { user.follow_topic!(topic) }.to change { user.following?(topic) }.to(true)
      end
    end

    context 'when user is already following topic' do
      before do
        user.user_topics.create(topic: topic)
      end

      it 'raises and error' do
        expect { user.follow_topic!(topic) }.to_not change(user.user_topics, :count)
        expect(user).to be_following(topic)
      end
    end
  end

  describe '#unfollow_topic!' do
    let!(:topic) { Fabricate(:topic) }

    it 'deletes user_topic' do
      user.user_topics.create(topic: topic)
      expect { user.unfollow_topic!(topic) }.to change { user.following?(topic) }.to(false)
    end
  end

  describe '#toggle_follow!' do
    let!(:topic) { Fabricate(:topic) }

    context 'when user is following topic' do
      it 'unfollows topic' do
        user.user_topics.create(topic: topic)
        expect { user.toggle_follow!(topic) }.to change { user.following?(topic) }.to(false)
      end
    end

    context 'when user is not following topic' do
      it 'follows topic' do
        user.user_topics.destroy_all
        expect { user.toggle_follow!(topic) }.to change { user.following?(topic) }.to(true)
      end
    end
  end
end
