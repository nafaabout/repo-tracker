require 'rails_helper'

RSpec.describe ArticleTopic, type: :model do
  it { should belong_to(:article) }
  it { should belong_to(:topic) }
end
