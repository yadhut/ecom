class Booking < ApplicationRecord

  before_validation do
    self.reference_id = generate_reference_no

  end
  belongs_to :hotel
  belongs_to :user
  has_one :payment

  private

  def generate_reference_no
    SecureRandom.hex(16)
  end
end
