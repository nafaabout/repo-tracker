# frozen_string_literal: true

require 'rails_helper'

# ApplicationRecord is an abstract class, we cannot instantiate it, so tests will use
# one of the core models
RSpec.describe ApplicationRecord do
  describe 'On create' do
    it 'sets id to a ulid' do
      owner = Fabricate.build(:owner)
      owner.run_callbacks(:create)

      expect(ULID.valid?(owner.id)).to be true
    end
  end

  describe 'On update' do
    it 'does not set id' do
      owner = Fabricate.build(:owner)
      expect { owner.run_callbacks(:update) }.to_not change(owner, :id)
    end
  end
end
