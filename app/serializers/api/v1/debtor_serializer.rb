# frozen_string_literal: true

module Api
  module V1
    class DebtorSerializer < ActiveModel::Serializer
      attributes :uid, :name

      belongs_to :booking
    end
  end
end
