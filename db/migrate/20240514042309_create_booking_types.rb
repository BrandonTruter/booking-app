class CreateBookingTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :booking_types do |t|
      t.uuid :uuid
      t.string :name
      t.string :color
      t.integer :duration
      t.integer :diary_uid
      t.integer :entity_uid
      t.integer :booking_uid
      t.integer :booking_status_uid
      t.references :bookable, polymorphic: true

      t.timestamps
    end

    add_index :booking_types, [ :diary_uid, :booking_uid ]
  end
end
