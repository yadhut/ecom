class Order < ApplicationRecord
  belongs_to :user

  validate :order_id, :amount, :type, presence: true

  before_validation do
    self.order_id = SecureRandom.alphanumeric(16).upcase
  end
end
