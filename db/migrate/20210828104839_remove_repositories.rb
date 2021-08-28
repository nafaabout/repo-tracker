class RemoveRepositories < ActiveRecord::Migration[6.1]
  def change
    drop_table :repositories
  end
end
