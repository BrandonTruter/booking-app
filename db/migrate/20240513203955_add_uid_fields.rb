class AddUidFields < ActiveRecord::Migration[7.1]
  def change
    add_column :diaries, :uid, :integer
    add_column :bookings, :uid, :integer
  end
end
