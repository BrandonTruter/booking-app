class CreateEntities < ActiveRecord::Migration[7.1]
  def change
    create_table :entities do |t|
      t.integer :uid
      t.string :title
      t.text :description
      t.string :username
      t.string :password
      t.string :token

      t.timestamps
    end
  end
end
