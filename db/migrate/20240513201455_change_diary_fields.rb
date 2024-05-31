class ChangeDiaryFields < ActiveRecord::Migration[7.1]
  def change
    remove_column :diaries, :description
    remove_column :diaries, :start_date
    remove_column :diaries, :end_date

    rename_column :diaries, :title, :name
    rename_column :diaries, :external_id, :uuid
    rename_column :diaries, :set_default, :disabled

    add_column :diaries, :treating_doctor_uid, :integer
    add_column :diaries, :booking_type_uid, :integer
    add_column :diaries, :booking_statuses, :json
    add_column :diaries, :booking_types, :json
  end
end
