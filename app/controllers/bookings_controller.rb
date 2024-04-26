class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(permitted_params)

    if @booking.save
      redirect_to edit_booking_path(@booking)
    else
      render :new
    end
  end

  def edit
    @booking = Booking.find(params[:idi])
  end

  def update
    @booking = Booking.find(params[:id])

    if @booking.update(permitted_params)
      redirect_to edit_booking_path(@booking)
    else
      render :edit
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
  end

  private

  def permitted_params
    params.require(:booking).permit(:reason, :start_date, :end_date, :type, :status)
  end
end
