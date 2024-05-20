class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :load_booking_data, only: [:edit]

  def index
    @bookings = Booking.all.order(created_at: :desc)
  end

  def new
    @booking = Booking.new
    @patients = Patient.all
    @debtors = Debtor.all
  end

  def show
  end

  def create
    @booking = Booking.new(permitted_params)

    respond_to do |format|
      if @booking.save
        format.html { redirect_to bookings_path }
        format.turbo_stream
      else
        format.html {
          puts @booking.errors.full_message
          @patients = Patient.all
          @debtors = Debtor.all

          render :new
        }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @booking.update(permitted_params)
        format.html { redirect_to bookings_path }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("booking_#{@booking.id}", partial: 'booking', locals: { booking: @booking })
        end
      else
        format.html { redirect_to edit_booking_path }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @booking.destroy
        format.html {
          redirect_to bookings_path
        }
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
    params
      .require(:booking)
      .permit(
        :reason,
        :end_at,
        :duration,
        :start_time,
        :diary_id,
        :debtor_id,
        :patient_id,
        :booking_type_uid,
        :booking_status_uid,
      )
  end

  def load_booking_data
    load_patients
    load_debtors
  end

  def client
    @client ||= GxWeb::Client.new
  end

  def load_patients
    @patients ||= client.list_patients | @booking.patients
  end

  def load_debtors
    @debtors ||= client.list_debtors | @booking.debtors
  end
end
