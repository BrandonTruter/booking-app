# frozen_string_literal: true

module Api
  module V1
    class BookingsSerializer < ActiveModel::Serializer
      attributes :uid, :title, :reason, :status, :booking_type, :start_at, :end_at, :duration

      has_one :debtor
      has_one :patient
      belongs_to :diary

      private

      def id
        return nil unless object.uid

        object.reload.uid
      end

      def start_at
        return nil unless object.start_at

        object.start_at.utc.iso8601
      end
    end
  end
end
