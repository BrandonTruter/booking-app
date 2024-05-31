# frozen_string_literal: true

module Api
  module V1
    class PatientSerializer < ActiveModel::Serializer
      attributes :uid, :debtor_uid, :name
    end
  end
end
