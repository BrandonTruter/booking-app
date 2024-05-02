class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.text :reason
      t.string :type
      t.string :status
      t.datetime :end_at
      t.datetime :start_at
      t.integer :duration
      t.integer :debtor_id
      t.integer :patient_id
      t.references :diary, null: false, foreign_key: true

      t.timestamps
    end
  end
end
