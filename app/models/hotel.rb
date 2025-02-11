class Hotel < ApplicationRecord
  has_many :bookings
  has_many :customers, through: :bookings, source: :user
  has_many :rooms
end
