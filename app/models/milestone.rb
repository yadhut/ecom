class Milestone < ApplicationRecord
  has_many :coupons
  has_many :users, through: :coupons

  before_validation do
    self.code = "SLASH#{discount}_#{SecureRandom.alphanumeric(6).upcase}"
  end
end
