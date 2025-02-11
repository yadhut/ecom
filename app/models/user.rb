class User < ApplicationRecord

  has_many :orders
  has_many :coupons
  has_many :milestones, through: :coupons
  has_many :bookings
  has_many :stays, through: :bookings, source: :hotel

  has_secure_password

  before_validation do
    self.uid = assign_uid
  end

  validates :first_name, :dob, presence: true
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def as_payload
    {
      uid:        uid,
      first_name: first_name,
      last_name:  last_name,
      email:      email,
      role:       role
    }
  end

  private
  def assign_uid
    uid = SecureRandom.alphanumeric(8).upcase
    "ID" + uid
  end
end