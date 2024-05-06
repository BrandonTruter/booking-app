# frozen_string_literal: true

module Api
  module V1
    class DiarySerializer < ActiveModel::Serializer
      attributes :uid, :name, :uuid

      has_many :booking_types, :booking_statuses

      def id
        object.uid
      end
    end
  end
end
