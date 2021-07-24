class CreateRepository < ActiveRecord::Migration[6.1]
  def change
    create_table :repositories, id: false do |t|
      t.binary :id, limit: 16, primary_key: true

      t.string :full_name, null: false
      t.string :owner, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
