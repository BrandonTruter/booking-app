class ChangeEntitiesDiariesReference < ActiveRecord::Migration[7.1]
  def change
    remove_reference :diaries, :entities
    add_column :diaries, :set_default, :boolean, default: true
    add_column :diaries, :external_id, :uuid

    add_reference :diaries, :entities, null: false, foreign_key: true
  end
end
