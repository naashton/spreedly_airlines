require 'Spreedly'

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
    spreedly = Spreedly.new
    pm_token = nil

    if(params[:pmd])
      # PMD 
      # - Get the receiver token. Create one if it doesn't exist.
      # - Create a payment method, get payment method token
      # - Use payment method token to process a purchase transaction
      receiver_token = spreedly.get_receiver_token
      payment_method = spreedly.create_payment_method(params)
      pm_token = payment_method['transaction']['payment_method']['token']
      # Save the payment method if user specified
      transaction = spreedly.payment_method_distribution(receiver_token, pm_token, params[:amount])
    else
      # Execute simple purchase transaction
      transaction = spreedly.create_purchase_transaction(params)
    end

    if(params[:store])
      PaymentMethod.create([
        {
          spreedly_payment_token: pm_token,
          primary_account_number: params[:credit_card],
          first_name: params[:first_name],
          last_name: params[:last_name],
          expiration_month: params[:expiration_month],
          expiration_year: params[:expiration_year],
        }
        ])
      end
      
    puts '--------------------------'
    puts transaction.code
    puts transaction.body
    puts '--------------------------'
    if transaction.code.kind_of? Net::HTTPSuccess 
      Transaction.create(
        { spreedly_transaction: transaction.body }
      )
    end
    
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
