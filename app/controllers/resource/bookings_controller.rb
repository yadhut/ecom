module Resource
  class BookingsController < ApplicationController
    before_action :current_user
    def bookings
      render :json =>   @current_user.stays
    end
  end
end
