class CreateDiaries < ActiveRecord::Migration[7.1]
  def change
    create_table :diaries do |t|
      t.string :title
      t.text :description
      t.date :start_date
      t.date :end_date
      t.integer :booking_id
      t.references :entities

      t.timestamps
    end
  end
end
