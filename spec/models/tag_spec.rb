require 'rails_helper'

RSpec.describe Tag, type: :model do
  it { should have_many(:tag_platforms) }
  it { should have_many(:platforms).through(:tag_platforms) }
end
