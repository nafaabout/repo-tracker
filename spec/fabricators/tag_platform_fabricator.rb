# == Schema Information
#
# Table name: tag_platforms
#
#  id          :uuid             not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  platform_id :uuid             not null
#  tag_id      :uuid             not null
#
# Indexes
#
#  index_tag_platforms_on_platform_id  (platform_id)
#  index_tag_platforms_on_tag_id       (tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (platform_id => platforms.id)
#  fk_rails_...  (tag_id => tags.id)
#
Fabricator(:tag_platform) do
  tag(fabricator: :tag)
  platform(fabricator: :platform)
end
