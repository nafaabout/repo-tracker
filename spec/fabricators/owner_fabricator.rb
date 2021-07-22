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
Fabricator(:owner) do
  login      { Faker::Internet.username }
  avatar_url { Faker::Avatar.image }
  name       { Faker::Name.name }
  owner_type { %w(orangization user).sample }
end
