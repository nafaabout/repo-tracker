# == Schema Information
#
# Table name: topics
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
Fabricator(:topic) do
  name { Faker::ProgrammingLanguage.name }
end
