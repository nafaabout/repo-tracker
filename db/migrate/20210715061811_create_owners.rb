class CreateOwners < ActiveRecord::Migration[6.1]
  def change
    create_table :owners, id: false do |t|
      t.binary :id, limit: 16, primary_key: true
      t.string :login, null: false
      t.string :avatar_url
      t.string :name, null: false
      t.string :owner_type, null: false

      t.timestamps
    end
  end
end
