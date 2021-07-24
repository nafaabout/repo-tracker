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
class Repository < ApplicationRecord

  def full_name
    "#{owner}/#{name}"
  end
end
