class AddCategoryToTopics < ActiveRecord::Migration[6.1]
  def change
    add_reference :topics, :category, null: true, foreign_key: true, type: :uuid
  end
end
