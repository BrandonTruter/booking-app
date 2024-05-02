class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  def index
    @bookings = Booking.all.order(created_at: :desc)
  end

  def new
    @booking = Booking.new
  end

  def show
  end

  def create
    @booking = Booking.new(permitted_params)

    respond_to do |format|
      if @booking.save
        format.html {
          redirect_to bookings_path, notice: "Booking scheduled successfully."
        }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @booking.update(permitted_params)
        format.html { redirect_to bookings_path }
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace("booking_#{@booking.id}", partial: 'booking', locals: { booking: @booking })
        }
      else
        format.html { redirect_to edit_booking_path }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @booking.destroy
        format.html { redirect_to bookings_path }
        format.turbo_stream
      else
        format.html { redirect_to bookings_path, notice: @booking.errors.full_message }
      end
    end
  end

  def search
    @bookings = Booking.where(start_at: params[:date].to_date.all_day)
    
    respond_to do |format|
      format.json {
        render json: render_to_string(partial: 'bookings/booking', collection: @bookings, formats: [:html])
      }
    end
  end

  private

  def set_booking
    @booking = Booking.joins(:diary).find(params[:id])
  end

  def permitted_params
    params.require(:booking)
           .permit(:reason, :start_at, :end_at, :booking_type, :status, :diary_id)
  end
end
