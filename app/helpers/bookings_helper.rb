module BookingsHelper
  def empty_options
    options_for_select([])
  end

  def patients_for_select(selected: nil, records: [])
    return empty_options unless records.present?

    patients = records.collect { |patient| [ patient.name, patient.id ] }
                      .sort_by { |patient| patient[1].to_i }

    selected ? options_for_select(patients, selected:) : options_for_select(patients)
  end

  def debtors_for_select(selected: nil, records: [])
    return empty_options unless records.present?

    debtors = records.collect { |debtor| [ debtor.name, debtor.id ] }
                     .sort_by { |debtor| debtor[1].to_i }

    selected ? options_for_select(debtors, selected:) : options_for_select(debtors)
  end

  def booking_types_for_select(selected: nil)
    BookingType.all.collect do |booking_type|
      [booking_type.name, booking_type.bookable_id]
    end.uniq
  end

end
