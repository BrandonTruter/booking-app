class Api::V1::BookingsController < ApplicationController
  before_action :open_session

  # GET /bookings
  def index
    render json: @client.list_bookings || Booking.all
  end

  # GET /bookings/2023-12-01
  def show
    render json: @client.search_booking(params[:date]) ||
                 Booking.find_by(start_at: params[:date])
  end

  def create
    render json: @client.create_booking(permitted_params)
  end

  def update
    render json: @client.update_booking(params)
  end

  def destroy
    render json: @client.update_booking(params)
  end

  private

  def open_session
    @client = GxWeb::Client.new
  end

  def permitted_params
    params.require(:bookings).permit(
      :entity_uid,
      :diary_uid,
      :booking_type_uid,
      :booking_status_uid,
      :patient_uid,
      :start_time,
      :duration,
      :reason,
      :cancelled
    )
  end
end
