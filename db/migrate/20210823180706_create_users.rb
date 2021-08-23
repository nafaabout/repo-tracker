class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :uid, null: false
      t.string :name, null: false
      t.string :nickname
      t.string :email
      t.string :token, null: false
      t.string :token_type, null: false
      t.string :image

      t.timestamps
    end
  end
end
