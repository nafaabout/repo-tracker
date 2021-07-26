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
Fabricator(:repository) do
  owner      { Faker::Name.first_name }
  name       { Faker::Name.last_name }
  after_build { |repo| repo.full_name = "#{repo.owner}/#{repo.name}" }
end
