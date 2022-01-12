class CreateUserTags < ActiveRecord::Migration[7.0]
  def change
    create_table :user_tags, id: :uuid do |t|
      t.belongs_to :user, null: false, foreign_key: true, type: :uuid
      t.belongs_to :tag, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
