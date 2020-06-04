class Payment < ApplicationRecord
  # relationship
  belongs_to :user
  has_many :orders

  # validation
  validates :total_price, presence: true, numericality: true

end
