module Resource
  class BookingsController < ApplicationController
    before_action :authorized

    def create_booking
      declared_params = booking_parms

      booking = Booking.new(declared_params.merge!(user: current_user, booking_date: Date.today))
      booking.payment.new()
    end
    def bookings
      render :json =>   @current_user.stays
    end
  end

  def booking_parms
    params.permit(:hotel_id, :checkin_date, :checkout_date)
  end
end
