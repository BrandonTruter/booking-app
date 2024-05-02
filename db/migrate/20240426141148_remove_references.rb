class RemoveReferences < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :bookings, :diaries
    remove_reference :diaries, :entities
  end
end
