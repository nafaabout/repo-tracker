# == Schema Information
#
# Table name: users
#
#  id         :uuid             not null, primary key
#  email      :string
#  image      :string
#  name       :string           not null
#  nickname   :string
#  token      :string           not null
#  token_type :string           not null
#  uid        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
Fabricator(:user) do
  uid      { ['github', Faker::Number.number].join('|') }
  name     { Faker::Name.name }
  nickname { Faker::Internet.username }
  email    { Faker::Internet.email }
  image    { Faker::Avatar.image }
  token    { Faker::Internet.uuid }
  token_type 'Bearer'
end
