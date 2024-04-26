class Booking < ApplicationRecord
  belongs_to :diary

  def self.generate_json
    {
      "uid": uid,
      "entity_uid": entity_uid,
      "booking_type_uid": booking_type_uid,
      "name": name,
      "uuid": uuid
    }
  end
end
