class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings
  # GET /bookings.json
  def index
    @bookings = Booking.all
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @flight = Flight.find(params[:format])
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create
    puts "HERE"
    puts '------------------'
    puts params
    # @booking = Booking.new(booking_params)
    puts Rails.application.credentials.spreedly[:environment_key]
    puts Rails.application.credentials.spreedly[:secret_key]
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.fetch(:booking, {})
    end
end
