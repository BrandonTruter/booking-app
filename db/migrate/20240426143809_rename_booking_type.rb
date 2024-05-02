class RenameBookingType < ActiveRecord::Migration[7.1]
  def change
    rename_column(:bookings, :type, :booking_type)
    add_belongs_to(:diaries, :entity, index: false)
    add_foreign_key(:diaries, :bookings, if_not_exists: true)
  end
end
