class ChangeBookingFields < ActiveRecord::Migration[7.1]
  def change
    remove_column :bookings, :status
    remove_column :bookings, :booking_type
    rename_column :bookings, :start_at, :start_time
    add_column :bookings, :cancelled, :boolean
    add_column :bookings, :uuid, :uuid
    add_column :bookings, :entity_uid, :integer
    add_column :bookings, :booking_type_uid, :integer
    add_column :bookings, :booking_status_uid, :integer
  end
end
