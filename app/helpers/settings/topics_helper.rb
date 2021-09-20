# frozen_string_literal: true

module Settings
  module TopicsHelper
    FOLLOWED_CLASSES = 'followed border-2 border-green-500 rounded-lg'
    TOPIC_CLASSES = 'inline-block p-2 m-4 h-24 w-24'
    def topic_classes(topic)
      return TOPIC_CLASSES unless current_user.following?(topic)

      "#{TOPIC_CLASSES} #{FOLLOWED_CLASSES}"
    end
  end
end
