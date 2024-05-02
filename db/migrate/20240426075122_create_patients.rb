class CreatePatients < ActiveRecord::Migration[7.1]
  def change
    create_table :patients do |t|
      t.integer :uid
      t.string :name
      t.integer :entity_uid
      t.integer :debtor_uid
      t.references :booking, null: true, foreign_key: true

      t.timestamps
    end
  end
end
