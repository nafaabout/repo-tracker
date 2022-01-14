# frozen_string_literal: true

module Settings
  module TagsHelper
    FOLLOWED_CLASSES = 'followed border-2 border-green-500 rounded-lg'
    TAG_CLASSES = 'tag inline-block p-2 m-4 h-24 w-24'
    def tag_classes(tag)
      return TAG_CLASSES unless current_user.following_tag?(tag)

      "#{TAG_CLASSES} #{FOLLOWED_CLASSES}"
    end
  end
end
