require 'rails_helper'

RSpec.describe TagPlatform, type: :model do
  it { should belong_to :tag }
  it { should belong_to :platform }
end
