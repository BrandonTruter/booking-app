# frozen_string_literal: true

module Api
  module V1
    class BookingSerializer < ActiveModel::Serializer
      attributes :uid, :uuid, :reason, :diary_id, :entity_uid, :booking_status_uid, :booking_type_uid, :debtor_id, :patient_id, :start_time, :end_at, :duration, :cancelled

      has_one :debtor
      has_one :patient
      belongs_to :diary

      private

      def timestamp
        return nil unless object.start_time

        object.start_time.utc.iso8601
      end
    end
  end
end
