class CreateDebtors < ActiveRecord::Migration[7.1]
  def change
    create_table :debtors do |t|
      t.integer :uid
      t.string :name
      t.integer :entity_uid
      t.string :patient_uids
      t.references :booking, null: true, foreign_key: true

      t.timestamps
    end
  end
end
