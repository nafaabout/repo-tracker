require 'rails_helper'

RSpec.describe Tag, type: :model do
  let!(:platform) { Fabricate(:platform) }

  it { should have_many(:tag_platforms) }
  it { should have_many(:platforms).through(:tag_platforms) }

  describe '#exists_on?' do
    context 'when tag already exists on platform' do
      let!(:tag) { platform.tags.first }

      it 'checks if tag belongs to a platform' do
        expect(tag.exists_on?(platform)).to be true
      end
    end

    context 'when tag does not exist on platform' do
      let!(:tag) { Fabricate(:tag_with_no_platform) }

      it 'checks if tag belongs to a platform' do
        expect(tag.exists_on?(platform)).to be false
      end
    end
  end

  describe '#add_platform' do
    context 'when tag already exists on platform' do
      let!(:tag) { platform.tags.first }

      it 'does nothing' do
        expect { tag.add_platform(platform) }.to_not change { tag.tag_platforms.count }
      end
    end

    context 'when tag does not exist on platform' do
      let!(:tag) { Fabricate(:tag_with_no_platform) }

      it 'creates a TagPlatform' do
        expect { tag.add_platform(platform) }.to change { tag.tag_platforms.count }.to(1)
      end
    end
  end
end
