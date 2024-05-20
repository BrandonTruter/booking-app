# ENTITY
entity = Entity.create!(
  title: 'APP 005',
  username: Rails.application.credentials.gxweb.username,
  password: Rails.application.credentials.gxweb.password,
  description: 'For interfacing with GoodX via an API that is part of the GoodX web'
)

# DIARIES
diary_json = GxWeb::Client.new.list_diaries
if diary_json && diary_json.key?(:data)
  diary_json[:data].each do |record|
    booking_types = []
    booking_states = []

    record[:booking_types].each do |bt|
      booking_types << {
        uid: bt[:uid],
        name: bt[:name],
        uuid: bt[:uuid],
        color: bt[:color]
      }
    end

    record[:booking_statuses].each do |bt|
      booking_states << {
        uid: bt[:uid],
        name: bt[:name],
        uuid: bt[:uuid],
        color: bt[:color]
      }
    end

    Diary.create!(
      name: record[:name],
      uid: record[:uid],
      uuid: record[:uuid],
      entity_id: entity.id,
      treating_doctor_uid: record[:treating_doctor_uid],
      booking_type_uid: record[:booking_type_uid],
      disabled: record[:disabled],
      booking_types: booking_types,
      booking_statuses: booking_states,
    )
  end
end

# PATIENTS
patients_json = GxWeb::Client.new.list_patients
if patients_json && patients_json.key?(:data)
  patients_json[:data].each do |record|
    Patient.create!(
      name: record[:surname],
      uid: record[:uid],
      debtor_uid: record[:debtor_uid],
      booking: Booking.last
    )
  end
end

# DEBTORS
debtors_json = GxWeb::Client.new.list_debtors
if debtors_json && debtors_json.key?(:data)
  debtors_json[:data].each do |record|
    Debtor.create!(
      name: record[:surname],
      uid: record[:uid],
      patient_uids: record[:patients].map {|p| p[:uid]}.join(','),
      booking: Booking.last
    )
  end
end

# BOOKINGS
booking_json = GxWeb::Client.new.list_bookings
if booking_json && booking_json.key?(:data)
  booking_json[:data].each do |record|
    diary = Diary.find_by(uid: record[:diary_uid])
    next unless diary.present?

    debtor = Debtor.find_or_initialize_by(uid: record[:patient_uid])
    patient = Patient.find_or_initialize_by(uid: record[:patient_uid])

    Booking.create!(
      reason: record[:reason] || "first test round",
      duration: record[:duration],
      start_time: record[:start_time],
      uid: record[:uid],
      uuid: record[:uuid],
      entity_uid: record[:entity_uid],
      booking_type_uid: record[:booking_type_uid],
      booking_status_uid: record[:booking_status_uid],
      cancelled: record[:cancelled],
      diary_id: diary&.id,
      debtor_id: debtor&.id,
      patient_id: patient&.id
    )
  end
end
