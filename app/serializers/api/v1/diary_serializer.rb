# frozen_string_literal: true

module Api
  module V1
    class DiarySerializer < ActiveModel::Serializer
      attributes :uid, :name

      has_many :bookings
      belongs_to :entity
    end
  end
end
