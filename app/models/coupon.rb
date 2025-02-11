class Coupon < ApplicationRecord
  belongs_to :user
  belongs_to :milestone
  STATES = %W[claimed used expired]

  before_validation do
    self.status = 'claimed'
  end

  before_create do
    coupon = Coupon.where(status: 'claimed')
    coupon.update(status: 'expired') if coupon.present? && coupon.created_at < DateTime.now - 10.days
  end
end
