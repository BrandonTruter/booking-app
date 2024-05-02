entity = Entity.create!(
  username: Rails.application.credentials.gxweb.username,
  password: Rails.application.credentials.gxweb.password,
  description: 'For interfacing with GoodX via an API that is part of the GoodX web',
  title: 'APP 005'
)

diary = Diary.create!(
  title: '05 Diary',
  start_date: '2023-11-01',
  end_date: '2023-12-01',
  entity_id: entity.id
)

booking = Booking.create!(
  reason: 'strictly testing',
  start_at: diary.start_date,
  end_at: diary.end_date,
  diary_id: diary.id,
  status: "Booked",
  booking_type: "Meeting"
)
