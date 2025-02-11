class Booking < ApplicationRecord
  belongs_to :hotel
  belongs_to :user
  has_one :payment
end
