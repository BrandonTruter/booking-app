class Api::V1::PatientsController < ApplicationController
  def index
    render json: GxWeb::Client.new.list_patients || Patient.all
  end
end
