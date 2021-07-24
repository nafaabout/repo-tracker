# == Schema Information
#
# Table name: repositories
#
#  id         :binary           not null, primary key
#  full_name  :string           not null
#  name       :string           not null
#  owner      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Repository, type: :model do
  describe '#full_name' do
    it "returns the full name of the repository owner/name" do
      repo = Fabricate.build(:repository)

      expect(repo.full_name).to eq("#{repo.owner}/#{repo.name}")
    end
  end
end
