class Api::V1::BookingsController < ApplicationController
  before_action :set_booking, only: %i[ show update destroy ]

  # GET /bookings
  def index
    @bookings = Booking.all

    render json: @bookings
  end

  # GET /bookings/1
  def show
    render json: @booking
  end

  # GET /bookings/search/2023-12-01
  def search
    @bookings = Booking.find_by(start_at: params[:date])

    render json: @bookings
  end

  # POST /bookings
  def create
    @booking = Booking.new(permitted_params)

    if @booking.save
      render json: @booking, status: :created, location: @booking
    else
      render json: @booking.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bookings/1
  def update
    if @booking.update(permitted_params)
      render json: @booking
    else
      render json: @booking.errors, status: :unprocessable_entity
    end
  end

  # DELETE /bookings/1
  def destroy
    @booking.destroy
  end

  private

    def set_booking
      @booking = Booking.find(params[:id])
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
