# frozen_string_literal: true

# == Schema Information
#
# Table name: owners
#
#  id         :binary           not null, primary key
#  avatar_url :string
#  login      :string           not null
#  name       :string           not null
#  owner_type :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Owner, type: :model do
  context 'On Create' do
    it 'sets id to a new ULID' do
      expect(Rails)
    end
  end
end
