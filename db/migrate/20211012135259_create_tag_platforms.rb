class CreateTagPlatforms < ActiveRecord::Migration[6.1]
  def change
    create_table :tag_platforms, id: :uuid do |t|
      t.belongs_to :tag, null: false, foreign_key: true, type: :uuid
      t.belongs_to :platform, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
