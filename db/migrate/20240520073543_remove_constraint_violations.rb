class RemoveConstraintViolations < ActiveRecord::Migration[7.1]
  def change
    remove_index :patients, :booking_id
    remove_index :debtors, :booking_id
  end
end
