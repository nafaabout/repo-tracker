require 'rails_helper'

RSpec.describe Topic, type: :model do
  it { should belong_to(:category) }
  it { should have_many(:user_topics).dependent(:destroy) }
end
