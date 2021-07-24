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
  id         ""
  owner      "MyString"
  name       "MyString"
  created_at "2021-07-23 10:20:51"
  updated_at "2021-07-23 10:20:51"
end
