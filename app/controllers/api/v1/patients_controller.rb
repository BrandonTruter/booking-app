class Api::V1::PatientsController < Api::BaseController
  def index
    render json: GxWeb::Client.new.list_patients || Patient.all
  end
end
