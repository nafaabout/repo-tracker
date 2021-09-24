class CreatePlatforms < ActiveRecord::Migration[6.1]
  def change
    create_table :platforms, id: :uuid do |t|
      t.string :name
      t.string :base_url
      t.string :api_url
      t.string :category

      t.timestamps
    end
  end
end
